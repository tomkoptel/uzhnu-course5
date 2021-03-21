import 'package:flutter/material.dart';

class BreedList extends StatefulWidget {
  BreedList({Key? key}) : super(key: key);

  @override
  _BreedListState createState() => _BreedListState();
}

class _BreedListState extends State<BreedList> {
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];

    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.amber[colorCodes[index]],
            child: Center(child: Text('Entry ${entries[index]}')),
          );
        });
  }
}
