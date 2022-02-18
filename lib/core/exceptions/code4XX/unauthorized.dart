import 'package:nut_flutter/core/exceptions/code4XX/network4xx_exception.dart';

class UnauthorizedException extends Network4XXException {
  const UnauthorizedException(
      {required String service, int code = 401, String message = 'You have to login first.'})
      : super(service: service, code: code, message: message);
}
