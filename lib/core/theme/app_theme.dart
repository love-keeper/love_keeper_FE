import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'app_typography.dart';

class AppTheme {
  static final _flexSchemeLight = FlexThemeData.light(
    scheme: FlexScheme.custom,
    useMaterial3: true,
    fontFamily: AppTypography.fontFamily,
    colors: const FlexSchemeColor(
      primary: Color(0xFFFF6B95),
      primaryContainer: Color(0xFFFF859B),
      secondary: Color(0xFF00CC88),
      secondaryContainer: Color(0xFFE5F6EF),
      error: Color(0xFFFF4D4D),
      tertiary: Color(0xFF747784),
    ),
    // 서브 테마 설정
    subThemesData: const FlexSubThemesData(
      interactionEffects: false,
      tintedDisabledControls: false,
      blendOnColors: false,
      useTextTheme: true,
      defaultRadius: 8,
      elevatedButtonRadius: 12,
      thickBorderWidth: 2.0,
      // Input Decoration Theme
      inputDecoratorBorderWidth: 1.0,
      inputDecoratorFocusedBorderWidth: 1.0,
      inputDecoratorRadius: 8,
      inputDecoratorUnfocusedBorderIsColored: false,
      // Button Theme
      elevatedButtonSchemeColor: SchemeColor.primary,
      elevatedButtonSecondarySchemeColor: SchemeColor.onPrimary,
      // Card Theme
      cardRadius: 16,
      // Dialog Theme
      dialogRadius: 16,
      // BottomSheet Theme
      bottomSheetRadius: 16,
      // Chip Theme
      chipRadius: 8,
      // PopupMenu Theme
      popupMenuRadius: 8,
    ),
  );

  // Light 테마
  static ThemeData light() {
    return _flexSchemeLight.copyWith(
      textTheme: AppTypography.textTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        hintStyle: const TextStyle(
          color: Color(0xFFC3C6CF),
          fontSize: 14,
          fontFamily: AppTypography.fontFamily,
        ),
        // contentPadding 전역 설정
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16, // 상하 패딩
          horizontal: 0, // 좌우 패딩
        ),
        // 입력 텍스트 스타일
        suffixStyle: TextStyle(
          color: Colors.grey[900],
          fontSize: 14,
          fontFamily: AppTypography.fontFamily,
        ),
        // 기본 텍스트 스타일
        labelStyle: TextStyle(
          color: Colors.grey[900],
          fontSize: 14,
          fontFamily: AppTypography.fontFamily,
        ),
        // 입력 텍스트 색상
        floatingLabelStyle: TextStyle(
          color: Colors.grey[900],
          fontSize: 14,
          fontFamily: AppTypography.fontFamily,
        ),

        // 기본 밑줄 스타일
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        // 포커스 상태의 밑줄 스타일
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFF6B95),
            width: 1,
          ),
        ),
        // 에러 상태의 밑줄 스타일
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: _flexSchemeLight.colorScheme.error,
            width: 1,
          ),
        ),
      ),
    );
  }

  // Dark 테마 (필요한 경우)
  static ThemeData dark() {
    return FlexThemeData.dark(
      scheme: FlexScheme.custom,
      useMaterial3: true,
      fontFamily: AppTypography.fontFamily,
      subThemesData: const FlexSubThemesData(
        defaultRadius: 8,
        elevatedButtonRadius: 12,
      ),
    ).copyWith(
      textTheme: AppTypography.textTheme,
    );
  }
}
