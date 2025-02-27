import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/core/config/routes/route_names.dart';
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
          Timer(const Duration(milliseconds: 500), () {
            context.pushReplacement(RouteNames.mainPage);
          });
        } else if (mounted) {
          _navigateToLogin();
        }
      } else if (mounted) {
        _navigateToLogin();
      }
    });
  }

  void _navigateToLogin() {
    Timer(const Duration(milliseconds: 500), () {
      context.pushReplacement(RouteNames.onboarding);
    });
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
