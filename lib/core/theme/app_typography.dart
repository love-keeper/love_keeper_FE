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
      // Display Large - Pretendard Black (900)
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontWeight: black,
        fontSize: 57,
        height: 1.12,
        letterSpacing: -0.25,
      ),

      // Display Medium - Pretendard ExtraBold (800)
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontWeight: extraBold,
        fontSize: 45,
        height: 1.15,
      ),

      // Display Small - Pretendard Bold (700)
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontWeight: bold,
        fontSize: 36,
        height: 1.22,
      ),

      // Headline Large - Pretendard SemiBold (600)
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontWeight: semiBold,
        fontSize: 32,
        height: 1.25,
      ),

      // Headline Medium - Pretendard Medium (500)
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontWeight: medium,
        fontSize: 28,
        height: 1.28,
      ),

      // Headline Small - Pretendard Regular (400)
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontWeight: regular,
        fontSize: 24,
        height: 1.33,
      ),

      // Title Large - Pretendard Medium (500)
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontWeight: medium,
        fontSize: 22,
        height: 1.27,
      ),

      // Title Medium - Pretendard Medium (500)
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontWeight: medium,
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
      ),

      // Title Small - Pretendard Medium (500)
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontWeight: medium,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.1,
      ),

      // Body Large - Pretendard Regular (400)
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontWeight: regular,
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
      ),

      // Body Medium - Pretendard Regular (400)
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontWeight: regular,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.25,
      ),

      // Body Small - Pretendard Regular (400)
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontWeight: regular,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.4,
      ),

      // Label Large - Pretendard Medium (500)
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontWeight: medium,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.1,
      ),

      // Label Medium - Pretendard Medium (500)
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontWeight: medium,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.5,
      ),

      // Label Small - Pretendard Medium (500)
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontWeight: medium,
        fontSize: 11,
        height: 1.45,
        letterSpacing: 0.5,
      ),
    );
  }
}