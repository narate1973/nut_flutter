import 'dart:async';

import 'package:dio/dio.dart';

extension HttpFutureDynamicExtensions<T> on Future<Response<dynamic>> {
  Future<Response<T>> mapJson<T>(FutureOr<T> Function(Map<String, Object?> response) f) {
    return then((Response<dynamic> response) async {
      T data;
      if (response.data is String) {
        final Map<String, dynamic> map = {};
        map['result'] = response.data;
        data = await f(map);
      } else {
        data = await f(response.data);
      }

      return response.copyWith(data: data);
    });
  }
}

extension HttpFutureExtensions<T> on Future<T> {}

extension HttpFutureResponseExtensions<T> on Future<Response<T>> {
  Future<T> noWrapResponse() {
    return then<T>((Response<T> response) {
      return Future.value(response.data);
    });
  }

  Future<Response<T>> catchWhenError(T? Function(DioError exception, StackTrace? stackTrace)? f) {
    return then(
      (value) => value,
      onError: (error, stackTrace) {
        if (f != null && error is DioError) {
          final resolve = f(error, null);
          final response = error.response.transformData(data: resolve);
          return Future.value(response);
        }
        throw error;
      },
    );
  }
}

extension ResponseExtensions on Response? {
  Response<T> copyWith<T>({
    T? data,
    Headers? headers,
    RequestOptions? requestOptions,
    bool? isRedirect,
    int? statusCode,
    String? statusMessage,
    List<RedirectRecord>? redirects,
    Map<String, dynamic>? extra,
  }) {
    return Response<T>(
      data: data ?? this?.data,
      headers: headers ?? this?.headers,
      requestOptions: requestOptions ?? this!.requestOptions,
      isRedirect: isRedirect ?? this?.isRedirect,
      statusCode: statusCode ?? this?.statusCode,
      statusMessage: statusMessage ?? this?.statusMessage,
      redirects: redirects ?? this?.redirects,
      extra: extra ?? this?.extra,
    );
  }

  Response<T> transformData<T>({
    required T? data,
    Headers? headers,
    RequestOptions? requestOptions,
    bool? isRedirect,
    int? statusCode,
    String? statusMessage,
    List<RedirectRecord>? redirects,
    Map<String, dynamic>? extra,
  }) {
    if (this == null) {
      this?.data = data;
      return this as Response<T>;
    }
    return Response<T>(
      data: data,
      headers: headers ?? this?.headers,
      requestOptions: requestOptions ?? this!.requestOptions,
      isRedirect: isRedirect ?? this?.isRedirect,
      statusCode: statusCode ?? this?.statusCode,
      statusMessage: statusMessage ?? this?.statusMessage,
      redirects: redirects ?? this?.redirects,
      extra: extra ?? this?.extra,
    );
  }
}
