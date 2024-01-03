import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:budget_manager_application/screens/wrapper.dart';
import 'package:budget_manager_application/firebase_options.dart';
import 'package:budget_manager_application/services/auth.dart';
import 'package:budget_manager_application/logic/appstate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyAppState()),
        StreamProvider<User?>.value(
          initialData: null,
          value: AuthService().user,
        ),
      ],
      child: MaterialApp(
        title: 'Budget Manager',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              secondary: const Color.fromARGB(255, 0, 18, 59),
              seedColor: const Color.fromARGB(255, 78, 111, 255)),
        ),
        home: const Wrapper(),
      ),
    );
  }
}


/* class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Budget Manager',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              secondary: const Color.fromARGB(255, 0, 18, 59),
              seedColor: const Color.fromARGB(255, 78, 111, 255)),
        ),
        home: Wrapper(),
      ),
    );
  }
} */