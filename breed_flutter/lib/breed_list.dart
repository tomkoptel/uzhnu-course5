import 'package:flutter/material.dart';
import 'domain/breed.dart';

class BreedList extends StatefulWidget {
  BreedList({Key? key, required this.entries}) : super(key: key);
  final List<Breed> entries;

  @override
  _BreedListState createState() => _BreedListState();
}

class _BreedListState extends State<BreedList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.entries.length,
        itemBuilder: (BuildContext context, int index) {
          return BreedItem(
            item: widget.entries[index],
            onFavorited: () {
              setState(() {
                final entry = widget.entries[index];
                final newEntry = entry.copyWith(isFavorite: !entry.isFavorite);
                widget.entries[index] = newEntry;
              });
            },
          );
        });
  }
}

class BreedItem extends StatelessWidget {
  const BreedItem({Key? key, required this.item, this.onFavorited})
      : super(key: key);
  final Breed item;
  final VoidCallback? onFavorited;

  @override
  Widget build(BuildContext context) {
    final IconData iconVal =
        item.isFavorite ? Icons.favorite : Icons.favorite_outline;

    var container = Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(item.name ?? ""),
          IconButton(
            icon: Icon(iconVal),
            tooltip: 'Add breed to favorites',
            onPressed: onFavorited,
          ),
        ],
      ),
    );
    return container;
  }
}
