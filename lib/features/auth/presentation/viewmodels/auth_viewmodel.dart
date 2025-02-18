// lib/features/auth/presentation/viewmodels/auth_viewmodel.dart
import 'dart:io';

import 'package:love_keeper_fe/features/auth/data/models/request/login_request.dart';
import 'package:love_keeper_fe/features/auth/data/models/request/signup_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repositories/auth_repository.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<void> signupLocal({
    required String email,
    required String password,
    required String nickname,
    required String birthDate,
    File? profileImage,
  }) async {
    state = const AsyncLoading();

    final request = SignupRequest.local(
      email: email,
      password: password,
      nickname: nickname,
      birthDate: birthDate,
    );

    final result = await ref.read(authRepositoryProvider).signup(
          request,
          profileImage: profileImage,
        );

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  Future<void> signupSocial({
    required String email,
    required String nickname,
    required String birthDate,
    required String provider,
    required String providerId,
    File? profileImage,
  }) async {
    state = const AsyncLoading();

    final request = SignupRequest.social(
      email: email,
      nickname: nickname,
      birthDate: birthDate,
      provider: provider,
      providerId: providerId,
    );

    final result = await ref.read(authRepositoryProvider).signup(
          request,
          profileImage: profileImage,
        );

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  Future<void> loginLocal({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final request = LoginRequest.local(
      email: email,
      password: password,
    );

    final result = await ref.read(authRepositoryProvider).login(request);

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  Future<void> loginSocial({
    required String email,
    required String provider,
    required String providerId,
  }) async {
    state = const AsyncLoading();

    final request = LoginRequest.social(
      email: email,
      provider: provider,
      providerId: providerId,
    );

    final result = await ref.read(authRepositoryProvider).login(request);

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  Future<void> logout() async {
    state = const AsyncLoading();

    final result = await ref.read(authRepositoryProvider).logout();

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }
}

@riverpod
class EmailVerificationViewModel extends _$EmailVerificationViewModel {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<void> sendCode(String email) async {
    state = const AsyncLoading();

    final result = await ref.read(authRepositoryProvider).sendCode(email);

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  Future<void> verifyCode(String email, int code) async {
    state = const AsyncLoading();

    final result =
        await ref.read(authRepositoryProvider).verifyCode(email, code);

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }
}

@riverpod
class PasswordResetViewModel extends _$PasswordResetViewModel {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<void> requestReset(String email) async {
    state = const AsyncLoading();

    final result =
        await ref.read(authRepositoryProvider).resetPasswordRequest(email);

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  Future<void> resetPassword(
      String email, String password, String passwordConfirm) async {
    state = const AsyncLoading();

    final result = await ref.read(authRepositoryProvider).resetPassword(
          email,
          password,
          passwordConfirm,
        );

    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }
}
