import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sns/model/account.dart';

import 'package:path_provider/path_provider.dart';

final Uri _uriHost = Uri.parse('http://localhost:8000');

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;
  static Account? myAccount;

  static Dio dio = Dio();
  static List<Cookie> cookies = [];

  Authentication() {
    dio.options.baseUrl = _uriHost.toString();
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.options.contentType = 'application/json';
  }

  Future<dynamic> signUp(
      {required String userName,
      required String email,
      required String password}) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      PersistCookieJar cookieJar =
          PersistCookieJar(storage: FileStorage(appDocPath + "/.cookies/"));

      cookieJar.saveFromResponse(_uriHost, cookies);
      dio.interceptors.add(CookieManager(cookieJar));

      final response = await dio.post('/v1/auth/signup',
          data: {
            'username': userName,
            'email': email,
            'password': password,
          },
          options: Options(
            contentType: Headers.jsonContentType,
          ));
      print("response");
      print(response);
      cookies = [...cookies, Cookie('session', response.data['access'])];
      cookieJar.saveFromResponse(_uriHost, cookies);

      List<Cookie> cookieList =
          await cookieJar.loadForRequest(_uriHost); // 格納されたクッキーを確認しているだけの処理
      print(cookieList);

      UserCredential newAccount = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return newAccount;
    } catch (e) {
      print(e);
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
