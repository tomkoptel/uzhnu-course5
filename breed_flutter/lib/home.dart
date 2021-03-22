import 'package:flutter/material.dart';
import 'domain/breed.dart';
import 'breed_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    final entries = <Breed>[
      Breed.make(name: 'Dog 1', isFavorite: true),
      Breed.make(name: 'Dog 2', isFavorite: false),
      Breed.make(name: 'Dog 3', isFavorite: false),
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
