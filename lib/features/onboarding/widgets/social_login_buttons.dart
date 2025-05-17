import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:love_keeper/core/providers/auth_state_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:love_keeper/core/config/routes/route_names.dart';
import 'package:love_keeper/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:love_keeper/features/couples/presentation/viewmodels/couples_viewmodel.dart';
import 'package:love_keeper/features/fcm/presentation/viewmodels/fcm_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth 추가

class SocialLoginButtons extends ConsumerWidget {
  const SocialLoginButtons({super.key});

  Future<void> _loginWithKakao(BuildContext context, WidgetRef ref) async {
    try {
      print('Kakao login button pressed (WebView mode)');
      // 항상 웹뷰 방식으로 로그인
      kakao.OAuthToken token =
          await kakao.UserApi.instance.loginWithKakaoAccount();

      kakao.User user = await kakao.UserApi.instance.me();
      print(
        'Kakao login success: id=${user.id}, email=${user.kakaoAccount?.email}',
      );

      await _handleLogin(
        ref,
        'KAKAO',
        user.id.toString(),
        user.kakaoAccount?.email ?? '',
        context,
      );
    } catch (e) {
      print('Kakao login error: $e');
      if (context.mounted) {
        _showError(context, '카카오 로그인 실패: $e');
      }
    }
  }

  Future<void> _loginWithNaver(BuildContext context, WidgetRef ref) async {
    try {
      print('Naver login button pressed');
      print(
        'Network check: ${await InternetAddress.lookup('nid.naver.com').then((_) => 'Connected').catchError((_) => 'Disconnected')}',
      );
      final NaverLoginResult result = await FlutterNaverLogin.logIn().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Naver login timed out after 10 seconds');
        },
      );
      print(
        'Naver login result: status=${result.status}, message=${result.errorMessage}',
      );
      if (result.status == NaverLoginStatus.loggedIn) {
        final NaverAccountResult account =
            await FlutterNaverLogin.currentAccount();
        print('Naver account: id=${account.id}, email=${account.email}');
        await _handleLogin(
          ref,
          'NAVER',
          account.id,
          account.email ?? '',
          context,
        );
      } else {
        throw Exception('Naver login failed: ${result.errorMessage}');
      }
    } catch (e) {
      print('Naver login error: $e');
      if (context.mounted) {
        _showError(context, '네이버 로그인 실패: $e');
      }
    }
  }

  Future<void> _loginWithApple(BuildContext context, WidgetRef ref) async {
    try {
      print('Apple login button pressed');
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oAuthProvider = OAuthProvider('apple.com');
      final firebaseCredential = oAuthProvider.credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        firebaseCredential,
      );
      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw Exception('Firebase 로그인 실패: 사용자 정보를 가져올 수 없습니다.');
      }

      final email = firebaseUser.email;
      if (email == null) {
        throw Exception('Firebase 사용자 이메일을 가져올 수 없습니다.');
      }

      await _handleLogin(ref, 'APPLE', firebaseUser.uid, email, context);
    } catch (e) {
      _showError(context, 'Apple 로그인 실패: $e');
    }
  }

  Future<void> _handleLogin(
    WidgetRef ref,
    String provider,
    String providerId,
    String email,
    BuildContext context,
  ) async {
    try {
      print(
        'Handle login: provider=$provider, providerId=$providerId, email=$email',
      );
      final authViewModel = ref.read(authViewModelProvider.notifier);
      final authStateNotifier = ref.read(authStateNotifierProvider.notifier);

      try {
        await authViewModel.emailDuplication(email);
        authStateNotifier.updateEmail(email);
        authStateNotifier.updateProvider(provider);
        authStateNotifier.updateProviderId(providerId);
        debugPrint('=== _handleLogin: Data saved to authState ===');
        final authState = ref.read(authStateNotifierProvider);
        debugPrint(
          'Verified state: email=${authState.email}, provider=${authState.provider}, providerId=${authState.providerId}',
        );

        if (context.mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              GoRouter.of(context).push(RouteNames.profileRegistrationPage);
            }
          });
        } else {
          print('Context not mounted, skipping navigation');
        }
      } on DioException catch (e) {
        if (e.response?.statusCode == 409) {
          final user = await authViewModel.login(
            email: email,
            provider: provider,
            providerId: providerId,
            context: context,
          );
          print('Existing user logged in: ${user.email}');

          final prefs = await SharedPreferences.getInstance();
          final accessToken = prefs.getString('access_token');
          if (accessToken == null) {
            throw Exception('Access Token not set after login');
          }

          await ref.read(fCMViewModelProvider.notifier).registerTokenOnLogin();
          final coupleInfo =
              await ref.read(couplesViewModelProvider.notifier).getCoupleInfo();

          if (context.mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                GoRouter.of(context).go(
                  coupleInfo != null
                      ? RouteNames.mainPage
                      : RouteNames.codeConnectPage,
                );
              }
            });
          }
        } else {
          print('DioException: ${e.response?.statusCode} - ${e.message}');
          rethrow;
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showError(context, '소셜 로그인 처리 중 오류: $e');
      }
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _loginWithApple(context, ref),
            child: _buildButton('assets/images/onboarding/Btn_Apple_Login.png'),
          ),
          const SizedBox(width: 18),
          GestureDetector(
            onTap: () => _loginWithKakao(context, ref),
            child: _buildButton('assets/images/onboarding/Btn_Kakao_Login.png'),
          ),
          const SizedBox(width: 18),
          GestureDetector(
            onTap: () => _loginWithNaver(context, ref),
            child: _buildButton('assets/images/onboarding/Btn_Naver_Login.png'),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String assetPath) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Image.asset(assetPath, fit: BoxFit.contain),
    );
  }
}
