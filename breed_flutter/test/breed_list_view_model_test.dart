import 'package:breed_flutter/data/breed_api.dart';
import 'package:breed_flutter/data/breed_database.dart';
import 'package:breed_flutter/domain/breed.dart';
import 'package:breed_flutter/presentation/breed_list_view_model.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'breed_list_view_model_test.mocks.dart';

@GenerateMocks([BreedDatabase, BreedApi])
void main() {
  final mockBreedDatabase = MockBreedDatabase();
  final mockBreedApi = MockBreedApi();

  final listViewModel =
      BreedListViewModel(database: mockBreedDatabase, api: mockBreedApi);

  final fakeDbBreed = Breed.make(name: "fakeDB");
  final fakeNetworkBreed = Breed.make(name: "fakeNetwork");

  group('when toggle breed item', () {
    setUp(() {
      when(mockBreedDatabase.all())
          .thenAnswer((_) => Future.value(<Breed>[fakeDbBreed]));
    });
    test('should toggle breed and load new list items', () async {
      await listViewModel.toggleFavorite(fakeDbBreed);

      var captured =
          verify(mockBreedDatabase.insert(captureAny)).captured.single;
      var capturedBreed = captured as Breed;
      expect(capturedBreed.isFavorite, !fakeDbBreed.isFavorite);
    });
  });

  group('when database returns cached', () {
    setUp(() {
      when(mockBreedDatabase.all())
          .thenAnswer((_) => Future.value(<Breed>[fakeDbBreed]));
    });

    test('api is not called', () async {
      await listViewModel.loadBreedList();

      final loaded = listViewModel.state
          .maybeWhen(loaded: (r) => r, orElse: () => const <Breed>[]);
      expect(loaded, <Breed>[fakeDbBreed]);

      verifyNoMoreInteractions(mockBreedApi);
    });
  });

  group('when database empty', () {
    setUp(() {
      var called = 0;
      when(mockBreedDatabase.all()).thenAnswer((_) {
        called++;
        if (called == 1) {
          return Future.value(<Breed>[]);
        } else {
          return Future.value(<Breed>[fakeDbBreed]);
        }
      });
    });

    test('and api returns success', () async {
      when(mockBreedApi.fetchBreeds())
          .thenAnswer((_) => Future.value(<Breed>[fakeNetworkBreed]));
      await listViewModel.loadBreedList();
      verify(mockBreedDatabase.insert(fakeNetworkBreed));

      final loaded = listViewModel.state
          .maybeWhen(loaded: (r) => r, orElse: () => const <Breed>[]);
      expect(loaded, <Breed>[fakeDbBreed]);
    });
  });
}
