import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'breed.dart';
import 'breed_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    final uuid = Uuid();
    final entries = <Breed>[
      Breed(uuid.v4(), name: 'Dog 1', isFavorite: true),
      Breed(uuid.v4(), name: 'Dog 2', isFavorite: false),
      Breed(uuid.v4(), name: 'Dog 3', isFavorite: false),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: Center(
        child: BreedList(entries: entries),
      ),
    );
  }
}
