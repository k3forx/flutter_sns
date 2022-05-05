import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sns/model/coffee_bean.dart';
import 'package:path_provider/path_provider.dart';

final Uri _uriHost = Uri.parse('http://localhost:8000');

class PostFirestore {
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
      final response = await dio.post(
        '/v1/coffee-beans',
        data: {
          'name': name,
          'farmName': farmName,
          'country': country,
          'roastDegree': roastDegree,
          'roastedAt': roastedAt,
        },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      return response.data["status"] == "success";
    } catch (e) {
      debugPrint(e.toString());
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
      final response = await dio.get(
        '/v1/coffee-beans',
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      List<CoffeeBean> coffeeBeans = (response.data["coffeeBeans"] as List)
          .map(
            (e) => CoffeeBean(
              id: e["id"],
              name: e["name"],
              farmName: e["farmName"],
              country: e["country"],
              roastDegree: e["roastDegree"],
              roastedAt: DateTime.parse(e["roastedAt"]),
            ),
          )
          .toList();
      debugPrint(response.statusMessage);
      debugPrint(response.toString());
      return coffeeBeans;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return <CoffeeBean>[];
    }
  }

  Future<CoffeeBean> getById(int id) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    PersistCookieJar cookieJar =
        PersistCookieJar(storage: FileStorage(appDocPath + "/.cookies/"));

    cookieJar.saveFromResponse(_uriHost, cookies);
    dio.interceptors.add(CookieManager(cookieJar));

    try {
      final response = await dio.get(
        '/v1/coffee-beans/$id',
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      return CoffeeBean(
        id: response.data["id"],
        name: response.data["name"],
        farmName: response.data["farmName"],
        country: response.data["country"],
        roastDegree: response.data["roastDegree"],
        roastedAt: DateTime.parse(response.data["roastedAt"]),
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
      return CoffeeBean();
    }
  }

  Future<dynamic> update(CoffeeBean coffeeBean) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    PersistCookieJar cookieJar =
        PersistCookieJar(storage: FileStorage(appDocPath + "/.cookies/"));

    cookieJar.saveFromResponse(_uriHost, cookies);
    dio.interceptors.add(CookieManager(cookieJar));

    try {
      final response = await dio.put(
        '/v1/coffee-beans/${coffeeBean.id}',
        data: {
          'name': coffeeBean.name,
          'farmName': coffeeBean.farmName,
          'country': coffeeBean.country,
          'roastDegree': coffeeBean.roastDegree,
          'roastedAt': coffeeBean.roastedAt.toString(),
        },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      return response.data["status"] == "success";
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
