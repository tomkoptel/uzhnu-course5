import 'package:breed_flutter/data/api.dart';
import 'package:breed_flutter/domain/breed.dart';
import 'package:test/test.dart';

void main() {
  test('test dog ceo API', () async {
    final List<Breed> breeds = await fetchBreeds();
    expect(breeds, isNot(isEmpty));
  });
}
