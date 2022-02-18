import 'dart:convert';

import 'package:equatable/equatable.dart';

class TokenModel with EquatableMixin {
  final String refreshToken;
  final String accessToken;

  const TokenModel({required this.accessToken, required this.refreshToken});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> tobeReturn = {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
    return tobeReturn;
  }

  static TokenModel getEmpty() => const TokenModel(accessToken: '', refreshToken: '');

  static TokenModel toModel(dynamic data) {
    if (data.runtimeType.toString() == 'String') {
      return TokenModel.fromJsonStr(data);
    } else {
      return TokenModel.fromJson(data);
    }
  }

  static TokenModel fromJson(Map<String, dynamic> map) => TokenModel(
        refreshToken: map['refreshToken'] as String,
        accessToken: map['accessToken'] as String,
      );

  static TokenModel fromJsonStr(String source) => TokenModel.fromJson(jsonDecode(source));

  bool get isEmptyToken => accessToken.isEmpty && refreshToken.isEmpty;

  bool get isNotEmptyToken => !isEmptyToken;

  bool get isAccessEmpty => accessToken.isEmpty;

  bool get isAccessNotEmpty => !isAccessEmpty;

  bool get isRefreshEmpty => refreshToken.isEmpty;

  bool get isRefreshNotEmpty => !isRefreshEmpty;

  @override
  List<Object?> get props => [refreshToken, accessToken];

  @override
  bool get stringify => true;

  String toJson() => json.encode(toMap());
}
