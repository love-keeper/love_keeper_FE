// lib/features/auth/views/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:love_keeper/features/auth/models/view_models/auth_view_model.dart';


class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Spacer(),
              // 로고 이미지
              SvgPicture.asset(
                'assets/splash/logo.svg',
                width: size.width * 0.4,
                height: size.width * 0.4,
              ),
              const Spacer(),
              // 이메일 로그인 버튼
              ElevatedButton(
                onPressed: () {
                  // 임시로 이메일 주소로 로그인 처리
                  ref.read(authViewModelProvider.notifier)
                     .login('codmsqor@naver.com');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD75A4A),
                  minimumSize: Size(size.width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'codmsqor@naver.com',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              // "또는" 텍스트
              const Text('또는'),
              const SizedBox(height: 20),
              // 소셜 로그인 버튼들
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialLoginButton(
                    'assets/login/kakao.svg',
                    onTap: () {},
                    color: const Color(0xFFFAE100),
                  ),
                  const SizedBox(width: 20),
                  _SocialLoginButton(
                    'assets/login/naver.svg',
                    onTap: () {},
                    color: const Color(0x1F03C9),
                  ),
                  const SizedBox(width: 20),
                  _SocialLoginButton(
                    'assets/login/google.svg',
                    onTap: () {},
                    color: const Color(0xFFD75A4A),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// 소셜 로그인 버튼 위젯
class _SocialLoginButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;
  final Color? color;

  const _SocialLoginButton(this.iconPath, {required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}