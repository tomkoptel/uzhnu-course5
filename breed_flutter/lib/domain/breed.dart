import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Breed {
  final String id;
  final String name;
  final List<String> races;
  final bool isFavorite;

  Breed(
    this.id,
    this.name,
    this.races,
    this.isFavorite,
  );

  factory Breed.make(
      {required String name,
      List<String> races = const <String>[],
      bool isFavorite = false}) {
    final uuid = Uuid();
    return Breed(uuid.v4(), name, races, isFavorite);
  }

  Breed copyWith({
    String? id,
    String? name,
    List<String>? race,
    bool? isFavorite,
  }) {
    return Breed(
      id ?? this.id,
      name ?? this.name,
      race ?? this.races,
      isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'race': races,
      'isFavorite': isFavorite,
    };
  }

  @override
  String toString() {
    return 'Breed(id: $id, name: $name, race: $races, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Breed &&
        other.id == id &&
        other.name == name &&
        listEquals(other.races, races) &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ races.hashCode ^ isFavorite.hashCode;
  }
}
