// lib/core/utils/app_logger.dart
import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();

  LogLevel minimumLogLevel = kDebugMode ? LogLevel.debug : LogLevel.info;

  void debug(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.debug, message, error: error, stackTrace: stackTrace);
  }

  void info(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.info, message, error: error, stackTrace: stackTrace);
  }

  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.warning, message, error: error, stackTrace: stackTrace);
  }

  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, error: error, stackTrace: stackTrace);
  }

  void _log(LogLevel level, String message,
      {Object? error, StackTrace? stackTrace}) {
    if (level.index < minimumLogLevel.index) return;

    final levelTag = level.toString().split('.').last.toUpperCase();
    final timestamp = DateTime.now().toString();
    final logMessage = '[$timestamp] $levelTag: $message';

    if (error != null) {
      debugPrint('$logMessage\nERROR: $error');
    } else {
      debugPrint(logMessage);
    }

    if (stackTrace != null && level == LogLevel.error) {
      debugPrintStack(stackTrace: stackTrace);
    }

    // Add additional crash reporting for production errors
    if (level == LogLevel.error && !kDebugMode) {
      // TODO: Integrate with a crash reporting service like Firebase Crashlytics
    }
  }
}

final logger = AppLogger();
