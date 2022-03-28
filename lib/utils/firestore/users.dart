import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sns/model/account.dart';

class UserFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users =
      _firestoreInstance.collection('users');

  static Future<dynamic> setUser(Account newAccount) async {
    try {
      await users.doc(newAccount.id).set({
        'name': newAccount.name,
        'user_id': newAccount.userId,
        'self_introduction': newAccount.selfIntroduction,
        'image_path': newAccount.imagePath,
        'created_time': Timestamp.now(),
        'updated_time': Timestamp.now(),
      });
      print('new account is created');
      return true;
    } on FirebaseException catch (e) {
      print('new account is failed to be created: ${e}');
      return false;
    }
  }
}
