import 'package:breed_flutter/domain/breed.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BreedDatabase {
  final Database database;

  BreedDatabase(this.database);

  static Future<BreedDatabase> create() async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE breeds(id TEXT PRIMARY KEY, name TEXT, races TEXT, isFavorite INTEGER)",
        );
      },
      version: 1,
    );
    return BreedDatabase(database);
  }

  Future<void> insert(Breed breed) async {
    await database.insert(
      'breeds',
      breed.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Breed>> all() async {
    final List<Map<String, dynamic>> maps = await database.query('breeds');

    return List.generate(maps.length, (i) {
      return Breed.fromMap(maps[i]);
    });
  }

  Future<void> clear() async {
    await database.delete('breeds');
  }
}
