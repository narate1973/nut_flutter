import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';

enum BuildMode { debug, release }

class BuildConfig {
  static bool get debug => !kReleaseMode;

  static bool get release => kReleaseMode;

  static String get appName => FlutterConfig.get('APP_NAME');

  static BuildMode get mode {
    if (BuildConfig.debug) {
      return BuildMode.debug;
    } else {
      return BuildMode.release;
    }
  }
}
