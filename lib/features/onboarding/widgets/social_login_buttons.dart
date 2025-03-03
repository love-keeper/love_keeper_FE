import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart'; // Apple 로그인 추가
import 'package:love_keeper_fe/core/config/routes/route_names.dart';
import 'package:love_keeper_fe/core/providers/auth_state_provider.dart';
import 'package:love_keeper_fe/features/auth/presentation/viewmodels/auth_viewmodel.dart';

class SocialLoginButtons extends ConsumerWidget {
  const SocialLoginButtons({super.key});

  Future<void> _loginWithKakao(BuildContext context, WidgetRef ref) async {
    try {
      print('Kakao login button pressed');
      bool isInstalled = await kakao.isKakaoTalkInstalled();
      kakao.OAuthToken token;

      if (isInstalled) {
        token = await kakao.UserApi.instance.loginWithKakaoTalk();
      } else {
        token = await kakao.UserApi.instance.loginWithKakaoAccount();
      }

      kakao.User user = await kakao.UserApi.instance.me();
      print('Kakao Login Success: ${token.accessToken}');
      print(
          'User Info: ${user.kakaoAccount?.email}, ${user.kakaoAccount?.profile?.nickname}');

      await ref.read(authViewModelProvider.notifier).handleSocialLogin(
            email: user.kakaoAccount?.email ?? '',
            provider: 'KAKAO',
            providerId: user.id.toString(),
            context: context,
          );
    } catch (e) {
      print('Kakao Login Failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('카카오 로그인 실패: $e')),
      );
    }
  }

  Future<void> _loginWithNaver(BuildContext context, WidgetRef ref) async {
    try {
      print('Naver login button pressed');
      final NaverLoginResult result = await FlutterNaverLogin.logIn();

      if (result.status == NaverLoginStatus.loggedIn) {
        final NaverAccountResult account =
            await FlutterNaverLogin.currentAccount();
        print('Naver Login Success: ${result.accessToken}');
        print('User Info: ${account.email}, ${account.nickname}');

        await ref.read(authViewModelProvider.notifier).handleSocialLogin(
              email: account.email ?? '',
              provider: 'NAVER',
              providerId: account.id,
              context: context,
            );
      } else {
        throw Exception('Naver login failed: ${result.errorMessage}');
      }
    } catch (e) {
      print('Naver Login Failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('네이버 로그인 실패: $e')),
      );
    }
  }

  Future<void> _loginWithApple(BuildContext context, WidgetRef ref) async {
    try {
      print('Apple login button pressed');
      print('Attempting SignInWithApple.getAppleIDCredential...');
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print('Apple Login Success: ${credential.userIdentifier}');
      print(
          'User Info: email=${credential.email}, name=${credential.givenName} ${credential.familyName}');
      print('Authorization Code: ${credential.authorizationCode}');
      print('Identity Token: ${credential.identityToken}');

      final email = credential.email ?? '';
      final providerId = credential.userIdentifier ?? '';

      if (providerId.isEmpty) {
        throw Exception('Apple login failed: No user identifier returned');
      }

      await ref.read(authViewModelProvider.notifier).handleSocialLogin(
            email: email.isNotEmpty ? email : 'apple_$providerId@example.com',
            provider: 'APPLE',
            providerId: providerId,
            context: context,
          );
    } catch (e) {
      print('Apple Login Failed: $e');
      print('Stack Trace: ${StackTrace.current}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Apple 로그인 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _loginWithApple(context, ref), // Apple 로그인 호출
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/onboarding/Btn_Apple LonIn.png', // 오타 확인 필요 (LonIn → Login)
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 18),
          GestureDetector(
            onTap: () => _loginWithKakao(context, ref),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/onboarding/Btn_Kakao LonIn.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 18),
          GestureDetector(
            onTap: () => _loginWithNaver(context, ref),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/onboarding/Btn_Naver LonIn.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
