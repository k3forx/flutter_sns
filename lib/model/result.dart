import 'dart:io';
import 'package:dio/dio.dart';

class Result<T> {
  String statusMessage;
  int statusCode;
  T? detailMessage;

  Result({
    this.statusMessage = "",
    this.statusCode = 0,
    this.detailMessage,
  });

  bool isSuccess() {
    return statusCode == HttpStatus.ok;
  }

  String getDetailMessage() {
    return detailMessage as String;
  }
}

Result newFromDioResponse(Response response) {
  return Result(
    statusCode: response.statusCode!,
    statusMessage: response.statusMessage!,
    detailMessage: response.data["message"],
  );
}
