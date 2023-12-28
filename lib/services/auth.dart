import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var logger = Logger();

  Future<User?> signInAnon() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      User? user = credential.user;
      user?.uid;
      return user;
    } catch (e) {
      logger.e('Error during sign-in: $e');
      return null;
    }
  }
}
