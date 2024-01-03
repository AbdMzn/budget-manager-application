import 'package:firebase_auth/firebase_auth.dart';
import '/screens/authenticate/authenticate.dart';
import '/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    //print('user Id: ${user?.uid}');

    if (user == null) {
      return const Authenticate();
    } else {
      return HomePage(user: user);
    }
  }
}
