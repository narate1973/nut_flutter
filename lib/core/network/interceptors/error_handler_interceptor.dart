import 'package:dio/dio.dart';
import 'package:nut_flutter/core/exceptions/code4XX/bad_request.dart';
import 'package:nut_flutter/core/exceptions/code4XX/server_not_found.dart';
import 'package:nut_flutter/core/exceptions/code4XX/timeout.dart';
import 'package:nut_flutter/core/exceptions/code5XX/internal_error_exception.dart';
import 'package:stack_trace/stack_trace.dart';

class NetworkErrorHandlerInterceptor extends InterceptorsWrapper {
  NetworkErrorHandlerInterceptor();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (_isError(response)) {
      final Exception? exception = _getExceptionFromResponse(response);
      if (exception != null) {
        final error = DioError(
          requestOptions: response.requestOptions,
          error: exception,
          response: response,
          type: DioErrorType.response,
        );
        error.stackTrace = Trace.current();
        handler.reject(error);
      } else {
        super.onResponse(response, handler);
      }
    } else {
      super.onResponse(response, handler);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (err.type == DioErrorType.connectTimeout || err.type == DioErrorType.receiveTimeout) {
      final int timeout = err.requestOptions.connectTimeout;
      err.error = NetworkTimeoutException(service: 'Http Interceptor', timeout: timeout);
      err.stackTrace = Trace.current();
      handler.reject(err);
    } else if (response != null && _isError(response)) {
      final Exception? exception = _getExceptionFromResponse(err.response);
      if (exception != null) {
        final error = DioError(
          requestOptions: response.requestOptions,
          error: exception,
          response: response,
          type: DioErrorType.response,
        );
        error.stackTrace = Trace.current();
        handler.reject(error);
      } else {
        super.onError(err, handler);
      }
    } else {
      super.onError(err, handler);
    }
  }

  bool _isError(Response? response) => response != null && (response.statusCode ?? 0) >= 300;

  Exception? _getExceptionFromResponse(Response? response) {
    final code = response?.statusCode ?? 0;
    String? errorMessage;
    if (response?.data is String) {
      errorMessage = response?.data;
    } else if (response?.data is Map) {
      errorMessage = response?.data['error'];
    }
    if (code >= 500) {
      return InternalErrorException(
        service: 'Http Interceptor',
        code: code,
        message: errorMessage ?? response?.statusMessage,
      );
    } else if (code >= 400) {
      if (code == 400) {
        return BadRequestException(
          service: 'Http Interceptor',
          message: errorMessage ?? response?.statusMessage,
        );
      } else if (code == 404) {
        return ServerNotFoundException(
          service: 'Http Interceptor',
          code: code,
          message: errorMessage ?? response?.statusMessage,
        );
      }
    }
    return null;
  }
}
