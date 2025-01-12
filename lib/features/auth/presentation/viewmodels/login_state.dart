import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required bool isLoading,
    String? errorMessage,
    User? user,
  }) = _LoginState;

  factory LoginState.initial() => const LoginState(
        isLoading: false,
        errorMessage: null,
        user: null,
      );
}