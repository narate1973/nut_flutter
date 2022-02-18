import 'dart:convert';

import 'package:nut_flutter/core/network/request/response_data.dart';

class LoginOrRegisterResponse extends ResponseData {
  final String accessToken;
  final String refreshToken;
  const LoginOrRegisterResponse({required this.accessToken, required this.refreshToken});

  static const String accessTokenField = 'accessToken';
  static const String refreshTokenField = 'refreshToken';

  @override
  List<Object?> get props => [accessToken, refreshToken];

  factory LoginOrRegisterResponse.fromMap(Map<String, dynamic> map) => LoginOrRegisterResponse(
        accessToken: map[accessTokenField] as String,
        refreshToken: map[refreshTokenField] as String,
      );

  factory LoginOrRegisterResponse.fromJson(String json) =>
      LoginOrRegisterResponse.fromMap(jsonDecode(json));
}
