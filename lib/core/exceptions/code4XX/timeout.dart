import 'package:nut_flutter/core/exceptions/code4XX/network4xx_exception.dart';

class NetworkTimeoutException extends Network4XXException {
  const NetworkTimeoutException({
    required String service,
    int code = 408,
    int? timeout,
    String? message,
  }) : super(service: service, code: code, message: message ?? 'Connecting timed out. [$timeout]');
}
