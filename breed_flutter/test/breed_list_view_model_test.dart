import 'package:breed_flutter/data/breed_api.dart';
import 'package:breed_flutter/data/breed_database.dart';
import 'package:breed_flutter/domain/breed.dart';
import 'package:breed_flutter/presentation/breed_list_view_model.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:test/test.dart';

void main() {
  test('test ability to get list of breeds from API', () async {
    final listViewModel = BreedListViewModel(database: FakeBreedDatabse(), api: FakeApi());
    await listViewModel.loadBreedList();

    final noResults = const <Breed>[];
    final loaded = listViewModel.state
        .maybeWhen(loaded: (r) => r, orElse: () => noResults);
    expect(loaded, isNot(isEmpty));
  });
}

class FakeApi extends BreedApi {
  @override
  Future<List<Breed>> fetchBreeds() {
    return Future.value(<Breed>[Breed.make(name: "??")]);
  }
}

class FakeBreedDatabse extends BreedDatabase {
  FakeBreedDatabse() : super(FakeDatabase());
}

class FakeDatabase extends Database {
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
