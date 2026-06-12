// ============================================================
// app_styles.dart
// Typography, text styles, decorations, and theme data
// Material Design 3 — Home Services App
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Central text styles and shared decoration helpers.
/// Uses Inter font family for a premium, modern look.
abstract class AppStyles {
  // ─── Font Family ───────────────────────────────────────────
  /// Use Google Fonts Inter for premium, modern typography
  static TextTheme get _interTextTheme =>
      GoogleFonts.interTextTheme();

  static const String fontFamily = 'Inter';

  // ─── Heading Styles ────────────────────────────────────────

  /// Large hero heading — e.g. "Welcome Back"
  static const TextStyle headingXL = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    height: 1.2,
  );

  /// Medium heading — e.g. section titles
  static const TextStyle headingLG = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.3,
  );

  /// Small heading — e.g. card titles
  static const TextStyle headingMD = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.4,
  );

  // ─── Body Styles ───────────────────────────────────────────

  /// Regular body text
  static const TextStyle bodyLG = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  /// Smaller body / supporting text
  static const TextStyle bodyMD = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Caption text
  static const TextStyle bodySM = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  // ─── Button Styles ─────────────────────────────────────────

  /// Label for primary buttons
  static const TextStyle buttonLG = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    height: 1.0,
  );

  /// Label for secondary / text buttons
  static const TextStyle buttonMD = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    height: 1.0,
  );

  // ─── Label Styles ──────────────────────────────────────────

  /// Input label text
  static const TextStyle labelMD = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  /// Small link / helper text
  static const TextStyle linkSM = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.solid,
  );

  // ─── Input Decoration ──────────────────────────────────────

  /// Returns a consistent InputDecoration for all text fields.
  /// Adapts to light/dark theme via [isDark] flag.
  static InputDecoration inputDecoration({
    required String hint,
    required Widget prefixIcon,
    Widget? suffixIcon,
    bool isDark = false,
    String? errorText,
  }) {
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color hintColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color fillColor = isDark ? AppColors.surfaceElevatedDark : AppColors.surfaceLight;

    return InputDecoration(
      hintText: hint,
      hintStyle: bodyMD.copyWith(color: hintColor),
      errorText: errorText,
      errorStyle: bodySM.copyWith(color: AppColors.error),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: borderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: borderColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.borderFocused, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
    );
  }

  // ─── Box Shadows ───────────────────────────────────────────

  /// Soft card elevation shadow (light mode)
  static List<BoxShadow> get cardShadowLight => [
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 24,
      spreadRadius: 0,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: Colors.white.withValues(alpha: 0.8),
      blurRadius: 0,
      spreadRadius: -1,
      offset: const Offset(0, -1),
    ),
  ];

  /// Soft card elevation shadow (dark mode)
  static List<BoxShadow> get cardShadowDark => [
    BoxShadow(
      color: AppColors.shadowDark,
      blurRadius: 32,
      spreadRadius: 0,
      offset: const Offset(0, 12),
    ),
  ];

  /// Button elevation shadow
  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.4),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 8),
    ),
  ];

  // ─── Material Theme Data ───────────────────────────────────

  /// Full light ThemeData using Material Design 3
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    textTheme: _interTextTheme,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.backgroundLight,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundLight,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 18),
        textStyle: buttonLG,
      ),
    ),
  );

  /// Full dark ThemeData using Material Design 3
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    textTheme: _interTextTheme.apply(
      bodyColor: AppColors.textPrimaryDark,
      displayColor: AppColors.textPrimaryDark,
    ),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColors.primaryLight,
      secondary: AppColors.accentLight,
      surface: AppColors.backgroundDark,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 18),
        textStyle: buttonLG,
      ),
    ),
  );
}
