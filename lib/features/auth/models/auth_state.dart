// lib/features/auth/models/auth_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isAuthenticated,
    String? email,
    String? error,
    @Default(false) bool isLoading,
  }) = _AuthState;
}