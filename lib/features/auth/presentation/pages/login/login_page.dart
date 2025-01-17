import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/auth/presentation/pages/login/%08widgets/onboarding_page.dart';
import 'package:love_keeper_fe/features/auth/presentation/pages/login/%08widgets/page_indicators.dart';
import 'package:love_keeper_fe/features/auth/presentation/pages/login/%08widgets/social_login_buttons.dart';
import 'models/onboarding_page_model.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        // 나중에 이미지로 바꿔야함.
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF995A6), // 더 밝은 핑크
              Color(0xFFFF6B95), // 더 진한 핑크
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: OnboardingPageModel.pages.length,
                  itemBuilder: (context, index) {
                    return OnboardingPage(
                      page: OnboardingPageModel.pages[index],
                      isLastPage: index == OnboardingPageModel.pages.length - 1,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    PageIndicators(
                      count: OnboardingPageModel.pages.length,
                      currentIndex: _currentPage,
                    ),
                    const SizedBox(height: 40),
                    FilledButton(
                      onPressed: () => context.push('/email-login'),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFFF5B82),
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        '시작하기',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (_currentPage == OnboardingPageModel.pages.length - 1) ...[
                      const SizedBox(height: 24),
                      const SocialLoginButtons(),
                    ],
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}