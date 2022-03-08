import 'package:dio/dio.dart';
import 'package:nut_flutter/core/network/app_api_service.dart';
import 'package:nut_flutter/features/auth/data/datasources/remotes/responses/login_or_register_response.dart';
import 'package:nut_flutter/features/auth/data/datasources/remotes/responses/refresh_token_response.dart';
import 'package:nut_flutter/features/auth/data/datasources/remotes/responses/test_response.dart';

abstract class LoginApiService {
  Future<Response<TestResponse>> test();
}

class LoginApiServiceImpl extends AppApiService implements LoginApiService {
  static const String loginOrRegisterEndpoint = 'api/auth/login-or-register';
  static const String refreshEndpoint = 'api/auth/refresh';
  static const String testEndpoint = 'work/me';

  Future<Response<TestResponse>> test() {
    return get(
      testEndpoint,
      converter: (json) => TestResponse.fromJson(json),
      isUseToken: true,
    );
  }

  Future<Response<LoginOrRegisterResponse>> loginOrRegister() {
    return post(
      loginOrRegisterEndpoint,
      converter: LoginOrRegisterResponse.fromMap,
      // isUseToken: true,
    );
  }

  Future<Response<RefreshTokenResponse>> refreshToken() {
    return post(
      refreshEndpoint,
      converter: RefreshTokenResponse.fromMap,
    );
  }
}
