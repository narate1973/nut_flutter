import 'package:dio/dio.dart';

class AccessTokenInterceptor extends InterceptorsWrapper {
  bool _isUseToken = true;
  String accessToken = '';

  set setIsUseToken(bool newValue) => _isUseToken = newValue;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_isUseToken && accessToken.isNotEmpty) {
      options.headers['Authorization'] = "Bearer " + accessToken;
    }
    if (!_isUseToken) {
      options.headers.clear();
    }
    super.onRequest(options, handler);
  }
}
