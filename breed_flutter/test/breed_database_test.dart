import 'package:breed_flutter/data/breed_database.dart';
import 'package:breed_flutter/domain/breed.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@Skip("sqflite cannot run on the machine")
void main() async {
  test("integrational test of BreedDatabase", () async {
    WidgetsFlutterBinding.ensureInitialized();

    await deleteDatabase(join(await getDatabasesPath(), 'doggie_database.db'));

    final BreedDatabase breedDatabase = await BreedDatabase.create();

    var fido = Breed.make(name: 'Fido', isFavorite: true);

    // Insert a dog into the database.
    await breedDatabase.insert(fido);

    // Print the list of dogs (only Fido for now).
    final List<Breed> nonEmptyBreeds = await breedDatabase.all();
    final Breed breedFromDb = nonEmptyBreeds[0];
    expect(breedFromDb, fido);

    // Delete Fido from the database.
    await breedDatabase.clear();

    // Print the list of dogs (empty).
    final List<Breed> emptyBreeds = await breedDatabase.all();
    expect(emptyBreeds.length, 0);
  });
}
