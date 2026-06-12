// ============================================================
// app_colors.dart
// Centralized color palette for Home Services App
// Supports both Light and Dark themes (Material Design 3)
// ============================================================

import 'package:flutter/material.dart';

/// Central color constants for the entire application.
/// All colors are defined here to ensure consistency and
/// easy theming across light and dark modes.
abstract class AppColors {
  // ─── Brand Palette ─────────────────────────────────────────
  /// Primary brand blue — used for primary actions & accents
  static const Color primary = Color(0xFF1565C0);

  /// Lighter shade of primary (for gradients, hover states)
  static const Color primaryLight = Color(0xFF1E88E5);

  /// Deep primary for dark mode surfaces
  static const Color primaryDark = Color(0xFF0D47A1);

  /// Teal accent — secondary brand color
  static const Color accent = Color(0xFF00ACC1);

  /// Light teal for subtle highlights
  static const Color accentLight = Color(0xFF26C6DA);

  // ─── Gradient ──────────────────────────────────────────────
  /// Primary gradient used on buttons and hero sections
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1565C0), Color(0xFF00ACC1)],
    stops: [0.0, 1.0],
  );

  /// Subtle background gradient (light mode)
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF0F4FF), Color(0xFFE8F5E9)],
  );

  /// Subtle background gradient (dark mode)
  static const LinearGradient backgroundGradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0A1628), Color(0xFF0D1F3C)],
  );

  // ─── Light Mode ────────────────────────────────────────────
  /// Default white background
  static const Color backgroundLight = Color(0xFFF8FAFF);

  /// Card / surface color for light mode
  static const Color surfaceLight = Color(0xFFFFFFFF);

  /// Primary text color (light mode)
  static const Color textPrimaryLight = Color(0xFF0D1B2E);

  /// Secondary / hint text color (light mode)
  static const Color textSecondaryLight = Color(0xFF6B7A99);

  /// Input field border — default state
  static const Color borderLight = Color(0xFFDDE3F0);

  /// Input field border — focused state
  static const Color borderFocused = Color(0xFF1565C0);

  /// Subtle divider color
  static const Color dividerLight = Color(0xFFEEF1FA);

  // ─── Dark Mode ─────────────────────────────────────────────
  /// Default dark background
  static const Color backgroundDark = Color(0xFF0A1628);

  /// Card / surface color for dark mode
  static const Color surfaceDark = Color(0xFF112240);

  /// Elevated surface (dark mode)
  static const Color surfaceElevatedDark = Color(0xFF1A3059);

  /// Primary text color (dark mode)
  static const Color textPrimaryDark = Color(0xFFE8EDF5);

  /// Secondary text color (dark mode)
  static const Color textSecondaryDark = Color(0xFF8BA3C7);

  /// Input field border (dark mode)
  static const Color borderDark = Color(0xFF1E3A5F);

  // ─── Semantic Colors ───────────────────────────────────────
  /// Success green
  static const Color success = Color(0xFF2ECC71);

  /// Error / validation red
  static const Color error = Color(0xFFE53935);

  /// Warning amber
  static const Color warning = Color(0xFFF39C12);

  /// Info blue
  static const Color info = Color(0xFF2196F3);

  // ─── Misc ──────────────────────────────────────────────────
  /// Transparent
  static const Color transparent = Colors.transparent;

  /// Shadow color (light mode)
  static const Color shadowLight = Color(0x1A1565C0);

  /// Shadow color (dark mode)
  static const Color shadowDark = Color(0x33000000);
}
