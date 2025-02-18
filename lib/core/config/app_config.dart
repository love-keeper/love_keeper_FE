// lib/core/config/app_config.dart
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config.g.dart';

enum Environment { dev, staging, prod }

class AppConfig {
  final Environment environment;
  final String apiBaseUrl;
  final int connectTimeoutSeconds;
  final int receiveTimeoutSeconds;
  final String appName;
  final String appVersion;

  AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.connectTimeoutSeconds,
    required this.receiveTimeoutSeconds,
    required this.appName,
    required this.appVersion,
  });

  factory AppConfig.development() {
    return AppConfig(
      environment: Environment.dev,
      apiBaseUrl: 'https://dev.lovekeeper.site/api',
      connectTimeoutSeconds: 10,
      receiveTimeoutSeconds: 5,
      appName: 'Love Keeper (Dev)',
      appVersion: '1.0.0-dev',
    );
  }

  factory AppConfig.staging() {
    return AppConfig(
      environment: Environment.staging,
      apiBaseUrl: 'https://staging.lovekeeper.site/api',
      connectTimeoutSeconds: 10,
      receiveTimeoutSeconds: 5,
      appName: 'Love Keeper (Staging)',
      appVersion: '1.0.0-staging',
    );
  }

  factory AppConfig.production() {
    return AppConfig(
      environment: Environment.prod,
      apiBaseUrl: 'https://lovekeeper.site/api',
      connectTimeoutSeconds: 5,
      receiveTimeoutSeconds: 3,
      appName: 'Love Keeper',
      appVersion: '1.0.0',
    );
  }

  bool get isDevelopment => environment == Environment.dev;
  bool get isStaging => environment == Environment.staging;
  bool get isProduction => environment == Environment.prod;
}

@Riverpod(keepAlive: true)
AppConfig appConfig(AppConfigRef ref) {
  if (kDebugMode) {
    return AppConfig.development();
  } else {
    // 여기서 플레이버에 따라 환경 설정을 결정할 수 있습니다.
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'prod');

    switch (flavor) {
      case 'dev':
        return AppConfig.development();
      case 'staging':
        return AppConfig.staging();
      case 'prod':
      default:
        return AppConfig.production();
    }
  }
}
