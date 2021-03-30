import 'package:breed_flutter/data/api.dart';
import 'package:breed_flutter/data/breed_database.dart';
import 'package:breed_flutter/domain/breed.dart';
import 'package:breed_flutter/presentation/breed_list_state.dart';
import 'package:state_notifier/state_notifier.dart';

class BreedListViewModel extends StateNotifier<BreedListState> {
  BreedListViewModel({required this.database})
      : super(const BreedListState.loading());
  final BreedDatabase database;

  Future<void> loadBreedList() async {
    try {
      final List<Breed> breeds = await fetchBreeds();
      state = BreedListState.loaded(breeds);
    } catch (ex) {
      state = BreedListState.error(ex.toString());
    }
  }
}
