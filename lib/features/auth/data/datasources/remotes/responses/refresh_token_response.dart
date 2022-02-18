import 'dart:convert';

import 'package:nut_flutter/core/network/request/response_data.dart';

class RefreshTokenResponse extends ResponseData {
  final String accessToken;
  final String refreshToken;
  RefreshTokenResponse({required this.accessToken, required this.refreshToken});

  static const String accessTokenField = 'accessToken';
  static const String refreshTokenField = 'refreshToken';

  @override
  List<Object?> get props => [accessTokenField, refreshTokenField];

  factory RefreshTokenResponse.fromMap(Map<String, dynamic> map) => RefreshTokenResponse(
        accessToken: map[accessTokenField] as String,
        refreshToken: map[accessTokenField] as String,
      );
}
