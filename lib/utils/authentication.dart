import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sns/model/account.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;
  static Account? myAccount;

  static Future<dynamic> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential newAccount = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return newAccount;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  static Future<dynamic> emailSignIn(
      {required String email, required String password}) async {
    try {
      final UserCredential _result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      currentFirebaseUser = _result.user;
      return _result;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  static Future<dynamic> signOut() async {
    await _firebaseAuth.signOut();
  }

  static Future<dynamic> deleteAuth() async {
    currentFirebaseUser!.delete();
  }
}
