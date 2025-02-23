import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/client/api_client.dart';

part 'dio_module.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8080',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      // contentType은 기본값으로 두고, multipart 요청에서 덮어씌워짐
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

        // /api/auth/signup은 multipart/form-data로 전송되므로 Content-Type 설정 제외
        if (options.path != '/api/auth/signup') {
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
            orElse: () => '');
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
              final apiClient = ref.read(apiClientProvider);
              final newAccessToken = await apiClient.reissue(refreshToken);
              await prefs.setString('access_token', newAccessToken);
              final options = error.requestOptions;
              if (options.path == '/api/auth/logout' ||
                  !options.path.startsWith('/api/auth')) {
                options.headers['Authorization'] = 'Bearer $newAccessToken';
              }
              if (options.path != '/api/auth/signup') {
                options.headers['Content-Type'] = 'application/json';
              }
              final retryResponse = await dio.fetch<Response<dynamic>>(options);
              handler.resolve(retryResponse);
            } catch (e) {
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

  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    logPrint: print,
  ));

  return dio;
}

@Riverpod(keepAlive: true)
ApiClient apiClient(ApiClientRef ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
}
