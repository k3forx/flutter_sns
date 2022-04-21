import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String id;
  String userName;
  String email;
  Timestamp? createdTime;
  Timestamp? updatedTime;

  String name;
  String userId;

  Account(
      {this.id = '',
      this.userName = '',
      this.email = '',
      this.name = '',
      this.userId = '',
      this.createdTime,
      this.updatedTime});
}
