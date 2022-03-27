import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;

  static Future<dynamic> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential newAccount = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      print('signUp is completed!');
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
      print('signIn is completed');
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }
}
