import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebase/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Future signInAnony() async {
    try {
      var result = await _auth.signInAnonymously();
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final DatabaseService databaseService =
          DatabaseService(uid: result.user!.uid);
      databaseService.updateUserInfo("new member", "0", 100);
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
