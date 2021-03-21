class Breed {
  final String id;
  final String? name;
  final bool isFavorite;

  Breed(this.id, {this.name, required this.isFavorite});

  Breed copyWith({String? name, bool isFavorite = false}) {
    return Breed(
      this.id,
      name: name ?? this.name,
      isFavorite: isFavorite,
    );
  }
}
