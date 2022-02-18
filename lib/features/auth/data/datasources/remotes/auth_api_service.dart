import 'package:dio/dio.dart';
import 'package:nut_flutter/core/network/app_api_service.dart';
import 'package:nut_flutter/features/auth/data/datasources/remotes/responses/login_or_register_response.dart';
import 'package:nut_flutter/features/auth/data/datasources/remotes/responses/refresh_token_response.dart';

abstract class _LoginApiServiceInterface {}

class LoginApiService extends AppApiService implements _LoginApiServiceInterface {
  static const String loginOrRegisterEndpoint = 'api/auth/login-or-register';
  static const String refreshEndpoint = 'api/auth/refresh';

  Future<Response<LoginOrRegisterResponse>> loginOrRegister() {
    return post(
      loginOrRegisterEndpoint,
      converter: LoginOrRegisterResponse.fromMap,
    );
  }

  Future<Response<RefreshTokenResponse>> refreshToken() {
    return post(
      refreshEndpoint,
      converter: RefreshTokenResponse.fromMap,
    );
  }
}
