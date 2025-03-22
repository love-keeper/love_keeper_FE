import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:love_keeper/core/network/client/api_client.dart';

part 'dio_module.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://lovekeeper.site',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final accessToken = prefs.getString('access_token');
        print('Requesting with Access Token: $accessToken for ${options.path}');

        // /api/auth로 시작하는 경로 중 /api/auth/logout만 토큰 추가
        if (accessToken != null &&
            (options.path == '/api/auth/logout' ||
                !options.path.startsWith('/api/auth'))) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        // /api/auth/reissue 요청 시 refresh_token을 Cookie로 추가
        if (options.path == '/api/auth/reissue') {
          final refreshToken = prefs.getString('refresh_token');
          if (refreshToken != null) {
            options.headers['Cookie'] = 'refresh_token=$refreshToken';
          }
        } else if (options.path != '/api/auth/signup') {
          options.headers['Content-Type'] = 'application/json';
        }
        handler.next(options);
      },

      onResponse: (response, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final accessToken = response.headers
            .value('Authorization')
            ?.replaceFirst('Bearer ', '');
        if (accessToken != null) {
          await prefs.setString('access_token', accessToken);
          print('Stored access token from response: $accessToken');
        }
        final refreshTokenCookie = response.headers['set-cookie']?.firstWhere(
          (cookie) => cookie.contains('refresh_token'),
          orElse: () => '',
        );
        if (refreshTokenCookie != null) {
          final refreshToken =
              refreshTokenCookie.split(';').first.split('=')[1];
          await prefs.setString('refresh_token', refreshToken);
          print('Stored refresh token from response: $refreshToken');
        }
        handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final prefs = await SharedPreferences.getInstance();
          final refreshToken = prefs.getString('refresh_token');
          if (refreshToken != null) {
            try {
              // body 없이 Cookie 헤더만 사용
              final apiClient = ref.read(apiClientProvider);
              final response = await apiClient.reissue(refreshToken);
              final newAccessToken = response.result;
              if (newAccessToken != null) {
                await prefs.setString('access_token', newAccessToken);
                final options = error.requestOptions;
                if (options.path == '/api/auth/logout' ||
                    !options.path.startsWith('/api/auth')) {
                  options.headers['Authorization'] = 'Bearer $newAccessToken';
                }
                if (options.path != '/api/auth/signup') {
                  options.headers['Content-Type'] = 'application/json';
                }
                final retryResponse = await dio.fetch(options);
                handler.resolve(retryResponse);
              } else {
                handler.next(error);
              }
            } catch (e) {
              print('Reissue failed: $e');
              handler.next(error);
            }
          } else {
            handler.next(error);
          }
        } else {
          handler.next(error);
        }
      },
    ),
  );

  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      logPrint: print,
    ),
  );

  return dio;
}

@Riverpod(keepAlive: true)
ApiClient apiClient(ApiClientRef ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
}
