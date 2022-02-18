import 'dart:convert';
import 'package:nut_flutter/core/network/request/base_request.dart';

abstract class RequestBody extends BaseRequest {
  const RequestBody();

  Map<String, Object?> toJson();

  String toJsonStr() => json.encode(toJson());
}
