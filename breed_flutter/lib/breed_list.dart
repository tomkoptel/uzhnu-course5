import 'package:flutter/material.dart';
import 'breed.dart';

class BreedList extends StatefulWidget {
  BreedList({Key? key}) : super(key: key);

  @override
  _BreedListState createState() => _BreedListState();
}

class _BreedListState extends State<BreedList> {
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['Dog 1', 'Dog 2', 'Dog 3'];

    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return BreedItem(
              item: Breed(name: '${entries[index]}', isFavorite: false));
        });
  }
}

class BreedItem extends StatelessWidget {
  const BreedItem({Key? key, required this.item}) : super(key: key);
  final Breed item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Text(item.name ?? ""),
    );
  }
}
