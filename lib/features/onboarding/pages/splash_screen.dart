import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper/core/config/routes/route_names.dart';
import 'package:love_keeper/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
// FCM 관련 import 추가
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:love_keeper/features/fcm/presentation/viewmodels/fcm_viewmodel.dart';

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
        _opacity = 0.0;
      });

      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken != null) {
        final isValid = await ref
            .read(authViewModelProvider.notifier)
            .checkToken(accessToken);
        if (isValid && mounted) {
          // 자동 로그인 성공 - FCM 토큰 등록 추가
          await _registerFCMToken();
          print('Token valid, navigating to MainPage');
          _navigateTo(RouteNames.mainPage);
        } else if (mounted) {
          print('Token invalid or expired, navigating to Onboarding');
          _navigateToLogin();
        }
      } else if (mounted) {
        print('No access token found, navigating to Onboarding');
        _navigateToLogin();
      }
    });
  }

  // FCM 토큰 등록 함수 추가
  Future<void> _registerFCMToken() async {
    try {
      final fcmViewModel = ref.read(fCMViewModelProvider.notifier);
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await fcmViewModel.registerToken(fcmToken);
        debugPrint('FCM token registered on auto-login: $fcmToken');
      }
    } catch (e) {
      debugPrint('Error registering FCM token: $e');
      // 토큰 등록에 실패해도 앱 사용에는 지장이 없도록 함
    }
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
    // 기존 build 메서드 유지
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
