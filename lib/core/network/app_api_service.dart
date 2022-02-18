import 'dart:async';

import 'package:dio/dio.dart';
import 'package:nut_flutter/core/extensions/response_extensions.dart';
import 'package:nut_flutter/core/network/interceptors/access_token_interceptor.dart';
import 'package:nut_flutter/core/network/interceptors/access_token_interceptorx.dart';
import 'package:nut_flutter/core/network/interceptors/error_handler_interceptor.dart';
import 'package:nut_flutter/core/network/interceptors/log_interceptor.dart';
import 'package:dartx/dartx.dart';
import 'package:nut_flutter/core/network/request/request_body.dart';

abstract class AppApiService {
  static final Dio _dio = Dio();

  static setUp({required String baseURL}) {
    _dio.options.baseUrl = baseURL;
  }

  AppApiService() {
    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 10000;
    _dio.interceptors.addAll([
      AccessTokenInterceptor(
        dio: _dio,
        retryAccessTokenLimit: 3,
      ), // Should call before another interceptor.
      NetworkErrorHandlerInterceptor(),
      HttpLogInterceptor(), // Add to last
    ]);
  }

  Future<Response<T>> get<T>(
    String endPoint, {
    Map<String, Object>? queryParameters,
    Options? options,
    bool isUseToken = true,
    T? Function(DioError exception, StackTrace? stackTrace)? catchError,
    required FutureOr<T> Function(Map<String, dynamic> json) converter,
  }) {
    TokenInterceptorX? tokenInterceptor = _getTokenInterceptor();
    tokenInterceptor?.isUseToken = isUseToken;
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
    TokenInterceptorX? tokenInterceptor = _getTokenInterceptor();
    tokenInterceptor?.isUseToken = isUseToken;
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
    TokenInterceptorX? tokenInterceptor = _getTokenInterceptor();
    tokenInterceptor?.isUseToken = isUseToken;
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
    TokenInterceptorX? tokenInterceptor = _getTokenInterceptor();
    tokenInterceptor?.isUseToken = isUseToken;
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

  TokenInterceptorX? _getTokenInterceptor() {
    return _dio.interceptors.firstOrNullWhere((interceptor) => interceptor is TokenInterceptorX)
        as TokenInterceptorX?;
  }
}
