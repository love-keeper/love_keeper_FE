import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

class AuthState {
  final String? email;
  final String? provider;
  final String? providerId;
  final String? password;
  final bool privacyPolicyAgreed;
  final bool? marketingAgreed;
  final bool termsOfServiceAgreed;

  AuthState({
    this.email,
    this.provider,
    this.providerId,
    this.password,
    this.privacyPolicyAgreed = false,
    this.marketingAgreed,
    this.termsOfServiceAgreed = false,
  });

  AuthState copyWith({
    String? email,
    String? provider,
    String? providerId,
    String? password,
    bool? privacyPolicyAgreed,
    bool? marketingAgreed,
    bool? termsOfServiceAgreed,
  }) {
    return AuthState(
      email: email ?? this.email,
      provider: provider ?? this.provider,
      providerId: providerId ?? this.providerId,
      password: password ?? this.password,
      privacyPolicyAgreed: privacyPolicyAgreed ?? this.privacyPolicyAgreed,
      marketingAgreed: marketingAgreed ?? this.marketingAgreed,
      termsOfServiceAgreed: termsOfServiceAgreed ?? this.termsOfServiceAgreed,
    );
  }
}

@Riverpod(keepAlive: true)
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AuthState build() => AuthState();

  void updateEmail(String email) {
    debugPrint('Updating email to: $email');
    state = state.copyWith(email: email);
    debugPrint(
      'Current state: email=${state.email}, provider=${state.provider}, providerId=${state.providerId}',
    );
  }

  void updateProvider(String provider) {
    debugPrint('Updating provider to: $provider');
    state = state.copyWith(provider: provider);
    debugPrint(
      'Current state: email=${state.email}, provider=${state.provider}, providerId=${state.providerId}',
    );
  }

  void updateProviderId(String providerId) {
    debugPrint('Updating providerId to: $providerId');
    state = state.copyWith(providerId: providerId);
    debugPrint(
      'Current state: email=${state.email}, provider=${state.provider}, providerId=${state.providerId}',
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateAgreements({
    required bool privacyPolicyAgreed,
    bool? marketingAgreed,
    required bool termsOfServiceAgreed,
  }) {
    state = state.copyWith(
      privacyPolicyAgreed: privacyPolicyAgreed,
      marketingAgreed: marketingAgreed,
      termsOfServiceAgreed: termsOfServiceAgreed,
    );
  }

  // 상태를 초기화하는 clear 메서드 유지
  void clear() {
    debugPrint('AuthStateNotifier cleared');
    state = AuthState();
  }
}
