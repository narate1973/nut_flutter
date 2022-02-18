import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nut_flutter/core/app_secure_storage/models/auth_token_model.dart';
import 'package:nut_flutter/core/app_secure_storage/token_local_database.dart';
import 'package:nut_flutter/core/exceptions/access_token_unauthorized.dart';
import 'package:nut_flutter/core/exceptions/should_open_signin_exception.dart';
import 'package:nut_flutter/core/extensions/dio_extensions.dart';
import 'package:nut_flutter/core/network/interceptors/access_token_interceptorx.dart';
import 'package:nut_flutter/core/utils/logger.dart';

class AccessTokenInterceptor extends TokenInterceptorX {
  AccessTokenInterceptor({
    required Dio dio,
    int retryAccessTokenLimit = 3,
    TokenDatabase tokenDatabase = const TokenDatabase(),
  })  : _dio = dio,
        _tokenDatabase = tokenDatabase,
        super(retryAccessTokenLimit: retryAccessTokenLimit);

  final Dio _dio;
  final TokenDatabase _tokenDatabase;

  // Set your fresh token endpoint.
  static const _refreshEndPoint = 'api/auth/refresh';

  @override
  int get tokenErrorCode => 401;

  @override
  void onHandleTokenResponse(Response response, ResponseInterceptorHandler handler) async {
    if (retryAccessTokenLimitCounter > 0) {
      final TokenModel token = await _tokenDatabase.loadToken();
      if (token.isRefreshNotEmpty) {
        refreshToken = token.refreshToken;

        final TokenModel? newToken = await _requestRefreshToken(refreshToken: refreshToken!);

        //Set token to interceptor
        accessToken = newToken?.accessToken;
        refreshToken = newToken?.refreshToken;

        if (newToken != null) {
          final newResponse = await _reCallService(response.requestOptions, newToken);
          handler.resolve(newResponse);
        } else {
          retryAccessTokenLimitCounter--;
          final error = DioError(
            requestOptions: response.requestOptions,
            error: const AccessTokenUnauthorizedException(),
            response: response,
            type: DioErrorType.response,
          );
          handler.reject(error);
        }
      }
    } else {
      final error = DioError(
        requestOptions: response.requestOptions,
        error: ShouldOpenSignInException(),
        response: response,
        type: DioErrorType.response,
      );
      handler.reject(error);
    }
  }

  @override
  void onHandleTokenError(DioError err, ErrorInterceptorHandler handler) async {
    if (retryAccessTokenLimitCounter > 0) {
      final TokenModel token = await _tokenDatabase.loadToken();
      if (token.isRefreshNotEmpty) {
        refreshToken = token.refreshToken;

        final TokenModel? newToken = await _requestRefreshToken(refreshToken: refreshToken!);

        //Set token to interceptor
        accessToken = newToken?.accessToken;
        refreshToken = newToken?.refreshToken;

        if (newToken != null) {
          final newResponse = await _reCallService(err.requestOptions, newToken);
          handler.resolve(newResponse);
        } else {
          retryAccessTokenLimitCounter--;
          handler.reject(err);
        }
      }
    } else {
      err.error = ShouldOpenSignInException();
      handler.reject(err);
    }
  }

  Future<TokenModel?> _requestRefreshToken({required String refreshToken}) {
    return _dio.post(_refreshEndPoint, data: jsonEncode({'refreshToken': refreshToken})).then(
        (value) async {
      if (value.statusCode == 200) {
        final TokenModel token = TokenModel.fromJson(value.data);
        _tokenDatabase.saveToken(token: token);

        return Future.value(token);
      } else if (value.statusCode == 500) {
        Log.e(value);
        return Future.value(null);
      }
    }, onError: (error, stackTrace) {
      Log.e(error, stackTrace);
      return Future.value(null);
    });
  }

  Future<Response> _reCallService(RequestOptions requestOptions, TokenModel token) async {
    accessToken = token.accessToken;
    refreshToken = token.refreshToken;

    //set bearer
    requestOptions.setHeaderTokenBearer(token.accessToken);

    //create request with new access token
    final opts = Options(method: requestOptions.method, headers: requestOptions.headers);
    return _dio.request(requestOptions.path,
        options: opts, data: requestOptions.data, queryParameters: requestOptions.queryParameters);
  }
}
