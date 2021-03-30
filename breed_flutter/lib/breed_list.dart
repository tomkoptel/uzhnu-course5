import 'package:flutter/material.dart';
import 'domain/breed.dart';
import 'package:breed_flutter/presentation/breed_list_state.dart';
import 'package:breed_flutter/presentation/breed_list_view_model.dart';
import 'package:provider/provider.dart';

class BreedList extends StatefulWidget {
  BreedList({Key? key, required this.viewModel}) : super(key: key);
  final BreedListViewModel viewModel;

  @override
  _BreedListState createState() => _BreedListState();
}

class _BreedListState extends State<BreedList> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadBreedList();
  }

  @override
  Widget build(BuildContext context) {
    return context
        .watch<BreedListState>()
        .when(loaded: showList, error: showError, loading: showLoading);
  }

  Widget showList(items) => ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final Breed breed = items[index];
        return BreedItem(
          item: breed,
          onFavorited: () {
            widget.viewModel.toggleFavorite(breed);
          },
        );
      });

  Widget showError(error) => Container(
        child: Center(
          child: Text(error),
        ),
      );

  Widget showLoading() => Container(
        child: Center(
          child: Text("Loading..."),
        ),
      );
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
          Text(item.name),
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
