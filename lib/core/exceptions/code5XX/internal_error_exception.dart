import 'package:nut_flutter/core/exceptions/code5XX/network5xx_exception.dart';

class InternalErrorException extends Network5XXException {
  const InternalErrorException(
      {required service, int code = 500, String? message = 'Service has something wrong.'})
      : super(service: service, code: code, message: message);
}
