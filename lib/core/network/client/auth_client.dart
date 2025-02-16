// lib/features/auth/data/datasources/auth_client.dart
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:love_keeper_fe/core/models/api_response.dart';
import 'package:love_keeper_fe/core/network/dio_client.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/login_request.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/signup_request.dart';
import 'package:love_keeper_fe/features/auth/data/models/response/login_response.dart';
import 'package:love_keeper_fe/features/auth/data/models/response/signup_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_client.g.dart';

@RestApi()
abstract class AuthRestClient {
  factory AuthRestClient(Dio dio) = _AuthRestClient;

  @POST('/auth/signup')
  @MultiPart()
  Future<ApiResponse<SignupResponse>> signup({
    @Part() required String email,
    @Part() required String nickname,
    @Part() required String birthDate,
    @Part() required String provider,
    @Part() String? providerId,
    @Part() String? password,
    @Part(name: 'profileImage', contentType: 'image/*') File? profileImage,
  });

  @POST('/auth/login')
  Future<ApiResponse<LoginResponse>> login(@Body() LoginRequest request);

  @POST('/auth/reissue')
  Future<ApiResponse<String>> reissue();

  @POST('/auth/logout')
  Future<ApiResponse<String>> logout();
}

@riverpod
AuthRestClient authClient(AuthClientRef ref) {
  final dio = ref.watch(dioClientProvider);
  return AuthRestClient(dio);
}

// Repository에서 사용할 때 필요한 확장 메서드
extension SignupRequestX on SignupRequest {
  Future<ApiResponse<SignupResponse>> submit(AuthRestClient client,
      {File? profileImage}) {
    return map(
      social: (request) => client.signup(
        email: request.email,
        nickname: request.nickname,
        birthDate: request.birthDate,
        provider: request.provider,
        providerId: request.providerId,
        profileImage: profileImage,
      ),
      local: (request) => client.signup(
        email: request.email,
        nickname: request.nickname,
        birthDate: request.birthDate,
        provider: request.provider,
        password: request.password,
        profileImage: profileImage,
      ),
    );
  }
}
