import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:love_keeper/core/config/routes/route_names.dart';
import 'package:love_keeper/core/providers/auth_state_provider.dart';
import 'package:love_keeper/features/auth/presentation/viewmodels/auth_viewmodel.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              print('Apple login button pressed');
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle, // BoxDecoration 내에서 shape 사용
              ),
              child: Image.asset(
                'assets/images/onboarding/Btn_Apple LonIn.png',
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
                shape: BoxShape.circle, // BoxDecoration 내에서 shape 사용
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
                shape: BoxShape.circle, // BoxDecoration 내에서 shape 사용
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
