import 'package:flutter/material.dart';

// 커스텀 색상 정의
class CustomColors {
  // 메인 컬러
  static const int _primaryValue = 0xFFFF6B95;
  static const MaterialColor primarySwatch = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFFFE5EC),
      100: Color(0xFFFFB3CE),
      200: Color(0xFFFF80AF),
      300: Color(0xFFFF4D91),
      400: Color(_primaryValue),  // primary color
      500: Color(0xFFFF1A6B),
      600: Color(0xFFFF0061),
      700: Color(0xFFE60057),
      800: Color(0xFFCC004D),
      900: Color(0xFFB30044),
    },
  );

  // 텍스트 컬러
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFFCCCCCC);

  // 배경 컬러
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF5F5F5);
  static const Color divider = Color(0xFFEEEEEE);

  // 상태 컬러
  static const Color success = Color(0xFF00CC88);
  static const Color error = Color(0xFFFF4D4D);
  static const Color warning = Color(0xFFFFAA00);
  static const Color info = Color(0xFF5B9FFF);
}