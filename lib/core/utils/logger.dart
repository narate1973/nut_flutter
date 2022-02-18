import 'dart:convert';

import 'package:ansicolor/ansicolor.dart';
import 'package:logger/logger.dart';
import 'package:nut_flutter/core/configs/build_config.dart';
import 'package:stack_trace/stack_trace.dart';

class Log {
  static Logger _logger = Logger();

  static final AnsiPen _title = AnsiPen()..white(bold: true);
  static final AnsiPen _error = AnsiPen()..red(bold: true);
  static final AnsiPen _success = AnsiPen()..green(bold: true);

  static void setup({
    LogFilter? filter,
    LogPrinter? printer,
    LogOutput? output,
    Level? level,
  }) {
    _logger = Logger(
      filter: filter,
      printer: printer,
      output: output,
      level: level,
    );
  }

  static void v(Object? message, [StackTrace? stackTrace]) {
    if (BuildConfig.debug) {
      _logger.v(message, null, stackTrace);
    }
  }

  static void d(Object? message, [StackTrace? stackTrace]) {
    if (BuildConfig.debug) {
      _logger.d(message, null, stackTrace);
    }
  }

  static void i(Object? message, [StackTrace? stackTrace]) {
    if (BuildConfig.debug) {
      _logger.i(message, null, stackTrace);
    }
  }

  static void w(Object? message, [StackTrace? stackTrace]) {
    if (BuildConfig.debug) {
      _logger.w(Trace.current(), message, stackTrace);
    }
  }

  static void e(Object? message, [StackTrace? stackTrace]) {
    if (BuildConfig.debug) {
      _logger.e(Trace.current(), message, stackTrace);
    }
  }

  static void title(Object? message) {
    if (BuildConfig.debug) {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String prettyPrint = encoder.convert(message);
      _printLong(_title(prettyPrint));
    }
  }

  static void success(Object? message) {
    if (BuildConfig.debug) {
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String prettyPrint = encoder.convert(message);
      _printLong(_success(prettyPrint));
    }
  }

  static void wtf(Object? message, [String? error, StackTrace? stackTrace]) {
    if (BuildConfig.debug) {
      _logger.wtf(Trace.current(), message, stackTrace);
    }
  }

  static void _printLong(Object? object) async {
    if (!BuildConfig.release) {
      int defaultPrintLength = 1020;
      if (object == null || object.toString().length <= defaultPrintLength) {
        print(object);
      } else {
        String log = object.toString();
        int start = 0;
        int endIndex = defaultPrintLength;
        int logLength = log.length;
        int tmpLogLength = log.length;
        while (endIndex < logLength) {
          print(log.substring(start, endIndex));
          endIndex += defaultPrintLength;
          start += defaultPrintLength;
          tmpLogLength -= defaultPrintLength;
        }
        if (tmpLogLength > 0) {
          print(log.substring(start, logLength));
        }
      }
    }
  }
}
