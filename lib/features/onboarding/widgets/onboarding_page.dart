import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:love_keeper_fe/core/config/routes/route_names.dart';
import 'package:love_keeper_fe/core/providers/auth_state_provider.dart';
import '../models/onboarding_page_model.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  final OnboardingPageModel page;
  final bool isLastPage;

  const OnboardingPage({
    super.key,
    required this.page,
    this.isLastPage = false,
  });

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  @override
  void initState() {
    super.initState();
    // Kakao SDK 초기화 (필요 시)
    kakao.KakaoSdk.init(nativeAppKey: '4082411ebc9c7d9b7612cc9c7bee8da8');
  }

  Future<void> _loginWithKakao() async {
    try {
      kakao.OAuthToken token =
          await kakao.UserApi.instance.loginWithKakaoAccount();
      kakao.User user = await kakao.UserApi.instance.me();
      ref
          .read(authStateNotifierProvider.notifier)
          .updateEmail(user.kakaoAccount?.email ?? '');
      ref.read(authStateNotifierProvider.notifier).updateProvider('KAKAO');
      ref
          .read(authStateNotifierProvider.notifier)
          .updateProviderId(user.id.toString());
      context.push(RouteNames.profileRegistrationPage);
    } catch (e) {
      debugPrint('Kakao login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('카카오 로그인 실패: $e')),
      );
    }
  }

  Future<void> _loginWithNaver() async {
    try {
      NaverLoginResult result = await FlutterNaverLogin.logIn();
      NaverAccessToken token = await FlutterNaverLogin.currentAccessToken;
      ref
          .read(authStateNotifierProvider.notifier)
          .updateEmail(result.account.email);
      ref.read(authStateNotifierProvider.notifier).updateProvider('NAVER');
      ref
          .read(authStateNotifierProvider.notifier)
          .updateProviderId(result.account.id);
      context.push(RouteNames.profileRegistrationPage);
    } catch (e) {
      debugPrint('Naver login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('네이버 로그인 실패: $e')),
      );
    }
  }

  Future<void> _loginWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );
      ref
          .read(authStateNotifierProvider.notifier)
          .updateEmail(credential.email ?? '');
      ref.read(authStateNotifierProvider.notifier).updateProvider('APPLE');
      ref
          .read(authStateNotifierProvider.notifier)
          .updateProviderId(credential.userIdentifier ?? '');
      context.push(RouteNames.profileRegistrationPage);
    } catch (e) {
      debugPrint('Apple login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Apple 로그인 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Center(
          child: Image.asset(
            widget.page.iconAsset,
            height: 280,
            width: 280,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          widget.page.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.55,
              ),
          textAlign: TextAlign.center,
        ),
        if (widget.page.subtitle != null) ...[
          const SizedBox(height: 11),
          Text(
            widget.page.subtitle!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  letterSpacing: -0.35,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 42),
        ],
        if (widget.isLastPage) ...[
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loginWithKakao,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child:
                const Text('카카오로 로그인', style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _loginWithNaver,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child:
                const Text('네이버로 로그인', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _loginWithApple,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child:
                const Text('Apple로 로그인', style: TextStyle(color: Colors.white)),
          ),
        ],
        const Spacer(),
      ],
    );
  }
}
