import 'package:nut_flutter/core/network/request/request_body.dart';

class LoginOrRegisterBody extends RequestBody {
  final String refreshToken;
  const LoginOrRegisterBody({required this.refreshToken});

  static const refreshTokenField = 'refreshToken';

  @override
  List<Object?> get props => [refreshToken];

  @override
  Map<String, Object?> toJson() => {refreshTokenField: refreshToken};
}
