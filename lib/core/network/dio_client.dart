// lib/core/network/dio_client.dart
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:love_keeper_fe/core/config/app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/di/app_providers.dart';
import '../config/routes/app_router.dart';
import '../utils/app_logger.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient(DioClientRef ref) {
  final config = ref.watch(appConfigProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  final router = ref.watch(appRouterProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: Duration(seconds: config.connectTimeoutSeconds),
      receiveTimeout: Duration(seconds: config.receiveTimeoutSeconds),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
    ),
  );

  // Logging interceptor for development
  if (config.isDevelopment) {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (log) => logger.debug(log.toString()),
    ));
  }

  // Authentication interceptor
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = prefs.getString('accessToken');
        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          try {
            final dio = Dio(BaseOptions(
              baseUrl: config.apiBaseUrl,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.acceptHeader: 'application/json',
              },
            ));

            // Include cookies in reissue request
            final cookies = prefs.getString('cookies');
            if (cookies != null) {
              dio.options.headers['Cookie'] = cookies;
            }

            final response = await dio.post('/auth/reissue');

            if (response.statusCode == 200) {
              // Extract and save new access token
              final authHeader = response.headers['authorization'];
              if (authHeader != null && authHeader.isNotEmpty) {
                final newAccessToken = authHeader[0].split(' ')[1];
                await prefs.setString('accessToken', newAccessToken);

                // Save cookies if present
                final setCookieHeader = response.headers['set-cookie'];
                if (setCookieHeader != null && setCookieHeader.isNotEmpty) {
                  await prefs.setString('cookies', setCookieHeader.join('; '));
                }

                // Retry original request with new token
                error.requestOptions.headers['Authorization'] =
                    'Bearer $newAccessToken';
                return handler.resolve(await Dio().fetch(error.requestOptions));
              }
            }
          } catch (e) {
            logger.error('Token refresh failed', error: e);
            // Clear auth data and redirect to login
            await prefs.remove('accessToken');
            await prefs.remove('cookies');
            if (router.configuration.navigatorKey.currentContext != null) {
              router.go('/login');
            }
          }
        }
        return handler.next(error);
      },
    ),
  );

  return dio;
}

@riverpod
RestClient apiClient(ApiClientRef ref) {
  final dio = ref.watch(dioClientProvider);
  return RestClient(dio);
}

// Base REST client - extend for specific needs
class RestClient {
  final Dio dio;

  RestClient(this.dio);

  // Common REST methods could be added here
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // Add other methods as needed
}
