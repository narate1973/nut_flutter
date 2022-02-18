import 'package:dio/dio.dart';
import 'package:nut_flutter/core/constants/network_constant.dart';

extension SetupHeader on RequestOptions {
  void setHeaderTokenBearer(String token) {
    headers[HttpHeader.headerAuthorize] = 'Bearer $token';
  }

  void removeHeaderToken() async {
    headers.remove(HttpHeader.headerAuthorize);
  }
}
