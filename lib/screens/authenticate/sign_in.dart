import '/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 205, 215),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 78, 111, 255),
        elevation: 0.0,
        title: const Text('Sign in'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: TextButton(
          child: const Text('sign in anon'),
          onPressed: () async {
            dynamic result = await _auth.signInAnon();
            if (result == null) {
              print('error signing in');
            } else {
              print('signed in');
              print(result.uid);
            }
          },
        ),
      ),
    );
  }
}
