import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/features/auth/presentation/viewmodels/auth_viewmodel.dart';
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
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    Timer(const Duration(seconds: 2), () async {
      setState(() {
        _opacity = 0.0;
      });

      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken != null) {
        final isValid = await ref
            .read(authViewModelProvider.notifier)
            .checkToken(accessToken);
        if (isValid && mounted) {
          // 토큰이 유효하면 메인 페이지로 이동
          Timer(const Duration(milliseconds: 500), () {
            context.pushReplacement('/main');
          });
        } else {
          // 토큰이 유효하지 않으면 로그인 페이지로 이동
          _navigateToLogin();
        }
      } else {
        // 토큰이 없으면 로그인 페이지로 이동
        _navigateToLogin();
      }
    });
  }

  void _navigateToLogin() {
    if (mounted) {
      Timer(const Duration(milliseconds: 500), () {
        context.pushReplacement('/login');
      });
    }
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
