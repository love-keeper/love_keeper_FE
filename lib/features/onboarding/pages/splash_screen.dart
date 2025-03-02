import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/core/config/routes/route_names.dart';
import 'package:love_keeper_fe/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:love_keeper_fe/features/couples/presentation/viewmodels/couples_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _checkInitialStatus();
  }

  Future<void> _checkInitialStatus() async {
    Timer(const Duration(seconds: 2), () async {
      setState(() {
        _opacity = 0.0; // 페이드 아웃 시작
      });

      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken != null) {
        // 1. 토큰 유효성 확인
        final isValid = await ref
            .read(authViewModelProvider.notifier)
            .checkToken(accessToken);
        if (isValid && mounted) {
          // 2. 커플 정보 확인
          try {
            await ref.read(couplesViewModelProvider.notifier).getCoupleInfo();
            // 커플 연결이 되어 있으면 MainPage로 이동
            _navigateTo(RouteNames.mainPage);
          } catch (e) {
            // 커플 연결이 안 되어 있으면 CodeConnectPage로 이동
            print('Couple info not found: $e');
            _navigateTo(RouteNames.codeConnectPage);
          }
        } else if (mounted) {
          _navigateToLogin(); // 토큰이 유효하지 않으면 로그인 화면으로
        }
      } else if (mounted) {
        _navigateToLogin(); // 토큰이 없으면 로그인 화면으로
      }
    });
  }

  void _navigateTo(String route) {
    Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.pushReplacement(route);
      }
    });
  }

  void _navigateToLogin() {
    _navigateTo(RouteNames.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 500),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/onboarding/Bg_Onboarding.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/onboarding/logo.png',
                  width: 116,
                  height: 94,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Love keeper',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.6,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
