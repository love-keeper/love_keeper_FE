// lib/features/auth/domain/repositories/auth_repository.dart
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/login_request.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/reset_password.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/reset_password_request.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/send_code_request.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/signup_request.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/verify_code_request.dart';
import 'package:love_keeper_fe/features/auth/data/models/response/login_response.dart';
import 'package:love_keeper_fe/features/auth/data/models/response/signup_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failures.dart';
import '../../data/datasources/auth_client.dart';

part 'auth_repository.g.dart';

abstract class IAuthRepository {
  Future<Either<Failure, SignupResponse>> signup(
    SignupRequest request, {
    File? profileImage,
  });

  Future<Either<Failure, LoginResponse>> login(LoginRequest request);

  Future<Either<Failure, String>> reissue();

  Future<Either<Failure, String>> logout();

  Future<Either<Failure, String>> sendCode(String email);

  Future<Either<Failure, String>> verifyCode(String email, int code);

  Future<Either<Failure, String>> resetPasswordRequest(String email);

  Future<Either<Failure, String>> resetPassword(
      String email, String password, String passwordConfirm);
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref.watch(authClientProvider));
}

class AuthRepository implements IAuthRepository {
  final AuthRestClient _client;

  AuthRepository(this._client);

  @override
  Future<Either<Failure, SignupResponse>> signup(
    SignupRequest request, {
    File? profileImage,
  }) async {
    try {
      final response =
          await request.submit(_client, profileImage: profileImage);
      if (response.result == null) {
        return left(const ServerFailure('서버에서 응답을 받을 수 없습니다.'));
      }
      return right(response.result!);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    try {
      final response = await _client.login(request);
      if (response.result == null) {
        return left(const ServerFailure('서버에서 응답을 받을 수 없습니다.'));
      }
      return right(response.result!);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> reissue() async {
    try {
      final response = await _client.reissue();
      if (response.result == null) {
        return left(const ServerFailure('서버에서 응답을 받을 수 없습니다.'));
      }
      return right(response.result!);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final response = await _client.logout();
      if (response.result == null) {
        return left(const ServerFailure('서버에서 응답을 받을 수 없습니다.'));
      }
      return right(response.result!);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendCode(String email) async {
    try {
      final request = SendCodeRequest(email: email);
      final response = await _client.sendCode(request);
      if (response.result == null) {
        return left(const ServerFailure('서버에서 응답을 받을 수 없습니다.'));
      }
      return right(response.result!);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyCode(String email, int code) async {
    try {
      final request = VerifyCodeRequest(email: email, code: code);
      final response = await _client.verifyCode(request);
      if (response.result == null) {
        return left(const ServerFailure('서버에서 응답을 받을 수 없습니다.'));
      }
      return right(response.result!);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> resetPasswordRequest(String email) async {
    try {
      final request = ResetPasswordRequest(email: email);
      final response = await _client.resetPasswordRequest(request);
      if (response.result == null) {
        return left(const ServerFailure('서버에서 응답을 받을 수 없습니다.'));
      }
      return right(response.result!);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(
      String email, String password, String passwordConfirm) async {
    if (password != passwordConfirm) {
      return left(const ValidationFailure('비밀번호가 일치하지 않습니다.'));
    }

    try {
      final request = ResetPassword(
        email: email,
        password: password,
        passwordConfirm: passwordConfirm,
      );
      final response = await _client.resetPassword(request);
      if (response.result == null) {
        return left(const ServerFailure('서버에서 응답을 받을 수 없습니다.'));
      }
      return right(response.result!);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
