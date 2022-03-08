import '../../../../../../core/network/request/response_data.dart';

class TestResponse extends ResponseData {
  final String message;
  const TestResponse({required this.message});

  static const String messageField = 'msg';

  factory TestResponse.fromJson(Map<String, dynamic> json) =>
      TestResponse(message: json[messageField] as String);

  @override
  List<Object?> get props => [message];
}
