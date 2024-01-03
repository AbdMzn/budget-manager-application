import 'package:budget_manager_application/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var logger = Logger();

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Future<User?> signInAnon() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      User? user = credential.user;
      user?.uid;
      return user;
    } catch (error) {
      logger.e('Error during sign-in: $error');
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      logger.e('Error during sign-in: $error');
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUserData(user.uid);
      return user;
    } catch (error) {
      logger.e('Error during registring: $error');
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      logger.e('Error during sign-out: $error');
      return null;
    }
  }
}
