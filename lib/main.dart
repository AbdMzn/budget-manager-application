import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_page.dart';
import 'logic/appstate.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Budget Manager',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              secondary: Color.fromARGB(255, 0, 18, 59),
              seedColor: Color.fromARGB(255, 78, 111, 255)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var appState = context.watch<MyAppState>();
    return Center();
  }
}
