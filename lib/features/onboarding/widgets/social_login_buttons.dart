import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12), // "또는" 텍스트 아래 12픽셀 간격
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Apple 로그인 버튼
          GestureDetector(
            onTap: () {
              // Apple 로그인 로직 추가
            },
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
          // Kakao 로그인 버튼
          GestureDetector(
            onTap: () {
              // Kakao 로그인 로직 추가
            },
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
          const SizedBox(width: 18),
          // Naver 로그인 버튼
          GestureDetector(
            onTap: () {
              // Naver 로그인 로직 추가
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/onboarding/Btn_Apple LonIn.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
