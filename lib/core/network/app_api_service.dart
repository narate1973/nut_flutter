import 'dart:async';

import 'package:dio/dio.dart';
import '../extensions/response_extensions.dart';
import 'interceptors/access_token_interceptor.dart';
import 'interceptors/error_handler_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'request/request_body.dart';

abstract class AppApiService {
  static final Dio _dio = Dio();

  static setUp({required String baseURL}) {
    _dio.options.baseUrl = baseURL;
  }

  AppApiService() {
    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 10000;
    _dio.interceptors.addAll([
      AccessTokenInterceptor(),
      NetworkErrorHandlerInterceptor(),
      HttpLogInterceptor(), // Add to last
    ]);
  }

  static _getAccessTokenInterceptor() =>
      _dio.interceptors.firstWhere((element) => element is AccessTokenInterceptor)
          as AccessTokenInterceptor;

  static setUpAccessToken(String accessToken) {
    final accessTokenInterceptor = _getAccessTokenInterceptor();
    accessTokenInterceptor.accessToken = accessToken;
  }

  Future<Response<T>> get<T>(
    String endPoint, {
    Map<String, Object>? queryParameters,
    Options? options,
    bool isUseToken = true,
    T? Function(DioError exception, StackTrace? stackTrace)? catchError,
    required FutureOr<T> Function(Map<String, dynamic> json) converter,
  }) {
    AccessTokenInterceptor? tokenInterceptor = _getAccessTokenInterceptor();
    tokenInterceptor?.setIsUseToken = isUseToken;
    return _dio
        .get(
          endPoint,
          queryParameters: queryParameters,
          options: options,
        )
        .mapJson((json) async => await converter(json))
        .catchWhenError(catchError);
  }

  Future<Response<T>> post<T>(
    String endPoint, {
    Map<String, Object>? queryParameters,
    RequestBody? data,
    Options? options,
    bool isUseToken = true,
    T? Function(DioError exception, StackTrace? stackTrace)? catchError,
    required FutureOr<T> Function(Map<String, dynamic> json) converter,
  }) {
    AccessTokenInterceptor? tokenInterceptor = _getAccessTokenInterceptor();
    tokenInterceptor?.setIsUseToken = isUseToken;
    return _dio
        .post(
          endPoint,
          data: data?.toJson(),
          queryParameters: queryParameters,
          options: options,
        )
        .mapJson((json) async => await converter(json))
        .catchWhenError(catchError);
  }

  Future<Response<T>> put<T>(
    String endPoint, {
    Map<String, Object>? queryParameters,
    RequestBody? data,
    Options? options,
    bool isUseToken = true,
    T? Function(DioError exception, StackTrace? stackTrace)? catchError,
    required FutureOr<T> Function(Map<String, dynamic> json) converter,
  }) {
    AccessTokenInterceptor? tokenInterceptor = _getAccessTokenInterceptor();
    tokenInterceptor?.setIsUseToken = isUseToken;
    return _dio
        .put(
          endPoint,
          data: data?.toJson(),
          queryParameters: queryParameters,
          options: options,
        )
        .mapJson((json) async => await converter(json))
        .catchWhenError(catchError);
  }

  Future<Response<T>> delete<T>(
    String endPoint, {
    Map<String, Object>? queryParameters,
    Options? options,
    RequestBody? data,
    bool isUseToken = true,
    T? Function(DioError exception, StackTrace? stackTrace)? catchError,
    required FutureOr<T> Function(Map<String, dynamic> json) converter,
  }) {
    AccessTokenInterceptor? tokenInterceptor = _getAccessTokenInterceptor();
    tokenInterceptor?.setIsUseToken = isUseToken;
    return _dio
        .delete(
          endPoint,
          data: data?.toJson(),
          queryParameters: queryParameters,
          options: options,
        )
        .mapJson((json) async => await converter(json))
        .catchWhenError(catchError);
  }
}
