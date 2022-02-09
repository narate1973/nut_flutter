import 'package:flutter_config/flutter_config.dart';

class AppEnv {
  static const String appNameField = "APP_NAME";

  static Future<void> load() => FlutterConfig.loadEnvVariables();

  static String get appNameValue => FlutterConfig.get(appNameField);
}
