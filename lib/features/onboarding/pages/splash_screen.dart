import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:love_keeper_fe/core/config/routes/route_names.dart';
import 'package:love_keeper_fe/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:love_keeper_fe/features/couples/presentation/viewmodels/couples_viewmodel.dart';
import 'package:love_keeper_fe/features/fcm/presentation/viewmodels/fcm_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  double _opacity = 1.0;
  String? _fcmToken;

  @override
  void initState() {
    super.initState();
    _checkInitialStatus();
    _fetchFCMToken();
  }

  Future<void> _fetchFCMToken() async {
    try {
      // Firebase 초기화 상태 확인
      final app = Firebase.app();
      print('Firebase app instance: $app');

      // 알림 권한 요청 및 상태 확인
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      print('Notification permission status: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // APNs 토큰 확인
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        print('APNs Token: $apnsToken');

        // FCM 토큰 가져오기
        final token = await FirebaseMessaging.instance.getToken();
        setState(() {
          _fcmToken = token;
        });
        print('FCM Token: $token');
      } else {
        print('Notification permission not granted');
      }
    } catch (e, stackTrace) {
      print('Failed to get FCM token: $e');
      print('StackTrace: $stackTrace');
      // 구체적인 오류 메시지 출력
      if (e is FirebaseException) {
        print('Firebase Exception: ${e.code} - ${e.message}');
      }
    }
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
          try {
            await _updateFCMToken();
            final coupleInfo = await ref
                .read(couplesViewModelProvider.notifier)
                .getCoupleInfo();
            print(
                'Couple info loaded: coupleId=${coupleInfo.coupleId}, partnerNickname=${coupleInfo.partnerNickname}');
            _navigateTo(RouteNames.mainPage);
          } catch (e) {
            print('Couple info not found: $e');
            _navigateTo(RouteNames.codeConnectPage);
          }
        } else if (mounted) {
          print('Token invalid or expired');
          _navigateToLogin();
        }
      } else if (mounted) {
        print('No access token found');
        _navigateToLogin();
      }
    });
  }

  Future<void> _updateFCMToken() async {
    final fcmViewModel = ref.read(fCMViewModelProvider.notifier);
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await fcmViewModel.registerToken(token);
        print('FCM token updated on splash screen: $token');
      } else {
        print('FCM token not available');
      }
    } catch (e) {
      print('FCM token update error: $e');
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
                if (_fcmToken != null)
                  Text(
                    'FCM Token: $_fcmToken',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
