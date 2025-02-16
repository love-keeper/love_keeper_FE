// lib/features/auth/data/datasources/auth_client.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:love_keeper_fe/core/network/dio_client.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/login_request.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/send_code_request.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/signup_request.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/verify_code_request.dart';
import 'package:love_keeper_fe/features/auth/data/models/response/login_response.dart';
import 'package:love_keeper_fe/features/auth/data/models/response/signup_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/api_response.dart';

part 'auth_client.g.dart';

@RestApi()
abstract class AuthRestClient {
  factory AuthRestClient(Dio dio) = _AuthRestClient;

  @POST('/auth/signup')
  @MultiPart()
  Future<ApiResponse<SignupResponse>> signup(
    @Part() String email,
    @Part() String nickname,
    @Part() String birthDate,
    @Part() String provider, {
    @Part() String? providerId,
    @Part() String? password,
    @Part(contentType: 'image/*') File? profileImage,
  });

  @POST('/auth/login')
  Future<ApiResponse<LoginResponse>> login(@Body() LoginRequest request);

  @POST('/auth/reissue')
  Future<ApiResponse<String>> reissue();

  @POST('/auth/logout')
  Future<ApiResponse<String>> logout();

  @POST('/auth/send-code')
  Future<ApiResponse<String>> sendCode(@Body() SendCodeRequest request);

  @POST('/auth/verify-code')
  Future<ApiResponse<String>> verifyCode(@Body() VerifyCodeRequest request);
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
        request.email,
        request.nickname,
        request.birthDate,
        request.provider,
        providerId: request.providerId,
        profileImage: profileImage,
      ),
      local: (request) => client.signup(
        request.email,
        request.nickname,
        request.birthDate,
        request.provider,
        password: request.password,
        profileImage: profileImage,
      ),
    );
  }
}
