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
            height: 240,
            width: 240,
          ),
        ),
        const SizedBox(height: 40),
        // 제목
        Text(
          page.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        if (page.subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            page.subtitle!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        const Spacer(),
      ],
    );
  }
}