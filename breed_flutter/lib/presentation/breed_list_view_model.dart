import 'package:breed_flutter/data/breed_api.dart';
import 'package:breed_flutter/data/breed_database.dart';
import 'package:breed_flutter/domain/breed.dart';
import 'package:breed_flutter/presentation/breed_list_state.dart';
import 'package:state_notifier/state_notifier.dart';

class BreedListViewModel extends StateNotifier<BreedListState> {
  BreedListViewModel({required this.database, required this.api})
      : super(const BreedListState.loading());
  final BreedDatabase database;
  final BreedApi api;

  Future<void> loadBreedList() async {
    try {
      final List<Breed> cachedBreeds = await database.all();
      if (cachedBreeds.isEmpty) {
        final List<Breed> networkBreeds = await api.fetchBreeds();
        networkBreeds.forEach((element) async {
          await database.insert(element);
        });
        final List<Breed> savedBreeds = await database.all();
        state = BreedListState.loaded(savedBreeds);
      } else {
        state = BreedListState.loaded(cachedBreeds);
      }
    } catch (ex) {
      state = BreedListState.error(ex.toString());
    }
  }

  Future<void> toggleFavorite(Breed breed) async {
    await database.insert(breed.copyWith(isFavorite: !breed.isFavorite));
    await loadBreedList();
  }
}
