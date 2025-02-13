import 'package:flutter/material.dart';

class AppTypography {
  static const String fontFamily = 'Pretendard';

  // Font Weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  static TextTheme get textTheme {
    return const TextTheme(
      // 실제로 자주 사용하는 스타일들만 남기고, 새로운 스타일 추가
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontWeight: medium,
        fontSize: 18,
        letterSpacing: -0.45,
        height: 1.27,
        color: Colors.black87,
      ),

      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontWeight: medium,
        fontSize: 16,
        letterSpacing: -0.4,
        height: 1.5,
        color: Colors.black87,
      ),

      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontWeight: medium,
        fontSize: 14,
        letterSpacing: -0.35,
        height: 1.43,
        color: Colors.black87,
      ),

      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontWeight: regular,
        fontSize: 16,
        letterSpacing: -0.4,
        height: 1.5,
        color: Colors.black87,
      ),

      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontWeight: regular,
        fontSize: 14,
        letterSpacing: -0.35,
        height: 1.43,
        color: Colors.black87,
      ),

      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontWeight: regular,
        fontSize: 12,
        letterSpacing: -0.3,
        height: 1.33,
        color: Colors.black87,
      ),

      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontWeight: medium,
        fontSize: 14,
        letterSpacing: -0.35,
        height: 1.43,
        color: Colors.black87,
      ),

      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontWeight: medium,
        fontSize: 12,
        letterSpacing: -0.3,
        height: 1.33,
        color: Colors.black87,
      ),

      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontWeight: medium,
        fontSize: 11,
        letterSpacing: -0.275,
        height: 1.45,
        color: Colors.black87,
      ),
    );
  }
}
