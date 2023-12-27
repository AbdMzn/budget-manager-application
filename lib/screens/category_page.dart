import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/logic/appstate.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          centerTitle: true,
          title: Text('Category'),
        ),
        body: ListView.builder(
          itemCount: appState.categories.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                appState.categories[index],
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              onTap: () {
                appState.setCategory(appState.categories[index]);
                Navigator.pop(context);
              },
            );
          },
        ));
  }
}
