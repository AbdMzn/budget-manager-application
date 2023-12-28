import 'package:firebase_auth/firebase_auth.dart';
import '/screens/authenticate/authenticate.dart';
import '/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Authenticate();
  }
}
