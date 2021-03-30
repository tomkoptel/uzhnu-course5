import 'package:breed_flutter/data/breed_api.dart';
import 'package:breed_flutter/domain/breed.dart';
import 'package:test/test.dart';

void main() {
  test('test dog ceo API', () async {
    final BreedApi api = BreedApi();
    final List<Breed> breeds = await api.fetchBreeds();
    expect(breeds, isNot(isEmpty));
  });
}
