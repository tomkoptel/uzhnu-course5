import 'dart:async';

import 'package:breed_flutter/domain/breed.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@Skip("sqflite cannot run on the machine")
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await deleteDatabase(join(await getDatabasesPath(), 'doggie_database.db'));

  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'doggie_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE breeds(id TEXT PRIMARY KEY, name TEXT, races TEXT, isFavorite INTEGER)",
      );
    },
    version: 1,
  );

  Future<void> insertDog(Breed breed) async {
    final Database db = await database;

    await db.insert(
      'breeds',
      breed.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Breed>> breeds() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('breeds');

    return List.generate(maps.length, (i) {
      return Breed.fromMap(maps[i]);
    });
  }

  Future<void> deleteDog(String id) async {
    final db = await database;

    await db.delete(
      'breeds',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteDB(String id) async {
    final Database db = await database;
    await db.delete(
      'breeds',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  var fido = Breed.make(name: 'Fido', isFavorite: true);

  // Insert a dog into the database.
  await insertDog(fido);

  // Print the list of dogs (only Fido for now).
  print(await breeds());

  // Delete Fido from the database.
  await deleteDog(fido.id);

  // Print the list of dogs (empty).
  print(await breeds());
}
