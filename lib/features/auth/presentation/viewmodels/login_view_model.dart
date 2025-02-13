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

  // 이메일 존재 여부 체크
  Future<bool> checkEmailExists(String email) async {
    state = state.copyWith(isLoading: true);

    try {
      // TODO: 실제 API 호출로 변경 필요
      // 임시 로직: 테스트를 위해 특정 이메일만 존재한다고 가정
      return email == "test@example.com";
    } catch (e) {
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

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
}
