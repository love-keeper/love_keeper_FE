import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

class AuthState {
  final String? email;
  final String? provider;
  final String? providerId;
  final String? password;

  AuthState({
    this.email,
    this.provider = 'LOCAL', // 기본값으로 LOCAL 설정
    this.providerId,
    this.password,
  });

  AuthState copyWith({
    String? email,
    String? provider,
    String? providerId,
    String? password,
  }) {
    return AuthState(
      email: email ?? this.email,
      provider: provider ?? this.provider,
      providerId: providerId ?? this.providerId,
      password: password ?? this.password,
    );
  }
}

@Riverpod(keepAlive: true)
class AuthStateNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState();
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updateProvider(String provider) {
    state = state.copyWith(provider: provider);
  }

  void updateProviderId(String? providerId) {
    state = state.copyWith(providerId: providerId);
  }

  void updatePassword(String? password) {
    state = state.copyWith(password: password);
  }

  void clear() {
    state = AuthState();
  }
}
