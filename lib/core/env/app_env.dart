import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  static Future<void> setUp() => dotenv.load(fileName: ".env");

  static String appName = dotenv.env['APP_NAME'] ?? 'empty';
}
