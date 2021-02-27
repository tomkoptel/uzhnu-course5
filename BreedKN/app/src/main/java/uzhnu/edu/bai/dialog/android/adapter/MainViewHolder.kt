package uzhnu.edu.bai.dialog.android.adapter

import android.view.View
import android.widget.ImageButton
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import uzhnu.edu.bai.dialog.android.R
import uzhnu.edu.bai.dialog.Breed

class MainViewHolder(itemView: View, breedClickListener: (Int) -> Unit) : RecyclerView.ViewHolder(itemView) {

    private val nameTextView = itemView.findViewById<TextView>(R.id.breed_name_text_view)
    private val favoriteButton = itemView.findViewById<ImageButton>(R.id.favorite_button)

    init {
        favoriteButton.setOnClickListener { breedClickListener(adapterPosition) }
    }

    fun bindTo(breed: Breed) {
        nameTextView.text = breed.name
        if (breed.favorite == 0L) {
            favoriteButton.setBackgroundResource(R.drawable.ic_favorite_border_24px)
        } else {
            favoriteButton.setBackgroundResource(R.drawable.ic_favorite_24px)
        }
    }
}
