import 'package:breed_flutter/data/breed_api.dart';
import 'package:breed_flutter/data/breed_database.dart';
import 'package:breed_flutter/presentation/breed_list_state.dart';
import 'package:breed_flutter/presentation/breed_list_view_model.dart';
import 'package:flutter/material.dart';
import 'breed_list.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static Widget create(BuildContext context, {Key? key, String? title}) {
    final database = context.read<BreedDatabase>();
    return StateNotifierProvider<BreedListViewModel, BreedListState>(
      create: (_) => BreedListViewModel(database: database, api: BreedApi()),
      child: HomePage(key: key, title: title),
    );
  }

  const HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<BreedListViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: Center(
        child: BreedList(viewModel: viewModel),
      ),
    );
  }
}
