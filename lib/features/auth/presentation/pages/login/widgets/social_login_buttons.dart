import 'package:flutter/material.dart';
import 'social_login_button.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialLoginButton(
          icon: 'assets/login_page/kakao.svg',
          onPressed: () {},
          backgroundColor: const Color(0xFFFEE500),
        ),
        const SizedBox(width: 16),
        SocialLoginButton(
          icon: 'assets/login_page/naver.svg',
          onPressed: () {},
          backgroundColor: const Color(0xFF03C75A),
        ),
        const SizedBox(width: 16),
        SocialLoginButton(
          icon: 'assets/login_page/google.svg',
          onPressed: () {},
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}