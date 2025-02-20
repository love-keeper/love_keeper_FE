import 'package:flutter/material.dart';
import '../models/onboarding_page_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingPageModel page;
  final bool isLastPage;

  const OnboardingPage({
    super.key,
    required this.page,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        // 아이콘
        Center(
          child: Image.asset(
            page.iconAsset,
            height: 280,
            width: 280,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 32),
        // 제목
        Text(
          page.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.55, // 약 22~24px 기준 -2.5%
              ),
          textAlign: TextAlign.center,
        ),
        if (page.subtitle != null) ...[
          const SizedBox(height: 11),
          Text(
            page.subtitle!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  letterSpacing: -0.35, // 약 14px 기준 -2.5%
                ),
            textAlign: TextAlign.center,
          ),
          // 부제 아래 42픽셀 간격 추가
          const SizedBox(height: 42),
        ],
      ],
    );
  }
}
