import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/breed_database.dart';
import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  final database = await BreedDatabase.create();

  runApp(Provider<BreedDatabase>(
    create: (_) => database,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Breed List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Flutter List of Breeds'),
    );
  }
}
