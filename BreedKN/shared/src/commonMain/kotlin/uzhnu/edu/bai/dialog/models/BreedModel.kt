package uzhnu.edu.bai.dialog.models

import uzhnu.edu.bai.dialog.DatabaseHelper
import uzhnu.edu.bai.dialog.currentTimeMillis
import uzhnu.edu.bai.dialog.Breed
import uzhnu.edu.bai.dialog.ktor.KtorApi
import uzhnu.edu.bai.dialog.sqldelight.asFlow
import co.touchlab.stately.ensureNeverFrozen
import com.russhwolf.settings.Settings
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.flowOn
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.launch
import org.koin.core.component.inject

class BreedModel(private val viewUpdate: (ItemDataSummary) -> Unit,
                 private val errorUpdate: (String) -> Unit) : BaseModel() {
    private val dbHelper: DatabaseHelper by inject()
    private val settings: Settings by inject()
    private val ktorApi: KtorApi by inject()

    companion object {
        internal const val DB_TIMESTAMP_KEY = "DbTimestampKey"
    }

    init {
        ensureNeverFrozen()
        mainScope.launch {
            dbHelper.selectAllItems().asFlow()
                .map { q ->
                    val itemList = q.executeAsList()
                    ItemDataSummary(itemList.maxByOrNull { it.name.length }, itemList)
                }
                .flowOn(Dispatchers.Default)
                .collect { summary ->
                    viewUpdate(summary)
                }
        }
    }

    fun getBreedsFromNetwork() {
        fun isBreedListStale(currentTimeMS: Long): Boolean {
            val lastDownloadTimeMS = settings.getLong(DB_TIMESTAMP_KEY, 0)
            val oneHourMS = 60 * 60 * 1000
            return (lastDownloadTimeMS + oneHourMS < currentTimeMS)
        }

        val currentTimeMS = currentTimeMillis()
        if (isBreedListStale(currentTimeMS)) {
            ktorScope.launch {
                try {
                    val breedResult = ktorApi.getJsonFromApi()
                    val breedList = breedResult.message.keys.toList()
                    insertBreedData(breedList)
                    settings.putLong(DB_TIMESTAMP_KEY, currentTimeMS)
                } catch (e:Exception){
                    errorUpdate("Unable to download breed list")
                }
            }
        }
    }

    private fun insertBreedData(breeds: List<String>) {
        mainScope.launch {
            dbHelper.insertBreeds(breeds)
        }
    }

    fun updateBreedFavorite(breed: Breed) {
        mainScope.launch {
            dbHelper.updateFavorite(breed.id, breed.favorite != 1L)
        }
    }
}

data class ItemDataSummary(val longestItem: Breed?, val allItems: List<Breed>)
