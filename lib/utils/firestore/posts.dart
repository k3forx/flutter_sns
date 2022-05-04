import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_sns/model/coffee_bean.dart';
import 'package:flutter_sns/model/post.dart';
import 'package:path_provider/path_provider.dart';

final Uri _uriHost = Uri.parse('http://localhost:8000');

class PostFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference posts =
      _firestoreInstance.collection('posts');
  static Dio dio = Dio();
  static List<Cookie> cookies = [];

  PostFirestore() {
    dio.options.baseUrl = _uriHost.toString();
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.options.contentType = 'application/json';
  }

  Future<dynamic> addPost(String name, String farmName, String country,
      String roastDegree, String roastedAt) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    PersistCookieJar cookieJar =
        PersistCookieJar(storage: FileStorage(appDocPath + "/.cookies/"));

    cookieJar.saveFromResponse(_uriHost, cookies);
    dio.interceptors.add(CookieManager(cookieJar));

    try {
      final response = await dio.post('/v1/coffee-beans',
          data: {
            'name': name,
            'farmName': farmName,
            'country': country,
            'roastDegree': roastDegree,
            'roastedAt': roastedAt,
          },
          options: Options(contentType: Headers.jsonContentType));
      print(response);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<CoffeeBean>> getAll() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    PersistCookieJar cookieJar =
        PersistCookieJar(storage: FileStorage(appDocPath + "/.cookies/"));

    cookieJar.saveFromResponse(_uriHost, cookies);
    dio.interceptors.add(CookieManager(cookieJar));

    try {
      final response = await dio.get('/v1/coffee-beans',
          options: Options(contentType: Headers.jsonContentType));
      print(response.data["coffeeBeans"]);
      List<CoffeeBean> coffeeBeans = (response.data["coffeeBeans"] as List)
          .map(
            (e) => CoffeeBean(
              id: e["id"],
              name: e["name"],
            ),
          )
          .toList();
      return coffeeBeans;
    } on Exception catch (e) {
      print(e);
      return <CoffeeBean>[];
    }
  }

  static Future<List<Post>?> getPostsByIds(List<String> ids) async {
    List<Post> postList = [];
    try {
      await Future.forEach(ids, (String id) async {
        var doc = await posts.doc(id).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Post post = Post(
          id: doc.id,
          content: data['content'],
          postAccountId: data['post_account_id'],
          createdTime: data['created_time'],
        );
      });
      return postList;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static Future<dynamic> deletePosts(String accountId) async {
    final CollectionReference _userPosts = _firestoreInstance
        .collection('users')
        .doc(accountId)
        .collection('my_posts');

    var snapshot = await _userPosts.get();
    snapshot.docs.forEach((doc) async {
      await posts.doc(doc.id).delete();
      _userPosts.doc(doc.id).delete();
    });
  }
}
