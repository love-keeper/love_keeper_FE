import 'package:love_keeper_fe/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/auth_repository.dart';
import './login_state.dart';

part 'login_view_model.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() => LoginState.initial();

  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    final result = await _authRepository.login(
      email: email,
      password: password,
    );

    state = result.fold(
      (failure) => state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (user) => state.copyWith(
        isLoading: false,
        errorMessage: null,
        user: user,
      ),
    );
  }

  Future<void> checkAutoLogin() async {
    state = state.copyWith(isLoading: true);

    final isSignedIn = await _authRepository.isSignedIn();
    if (!isSignedIn) {
      state = state.copyWith(isLoading: false);
      return;
    }

    final result = await _authRepository.getCurrentUser();
    state = result.fold(
      (failure) => state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (user) => state.copyWith(
        isLoading: false,
        errorMessage: null,
        user: user,
      ),
    );
  }

  void resetError() {
    state = state.copyWith(errorMessage: null);
  }
}