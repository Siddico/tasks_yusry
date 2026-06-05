import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  const primary = Color(0xFFFF6B00); // Orange accent
  const secondary = Color(0xFF0F172A); // Slate Black for headings/primary elements
  const tertiary = Color(0xFF64748B); // Slate Grey for subtext
  const surface = Color(0xFFFFFFFF); // White backgrounds

  final colorScheme = ColorScheme.fromSeed(
    seedColor: primary,
    brightness: Brightness.light,
  ).copyWith(
    primary: primary,
    secondary: secondary,
    tertiary: tertiary,
    surface: surface,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: surface,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      foregroundColor: Color(0xFF0F172A),
      iconTheme: IconThemeData(color: Color(0xFF0F172A)),
    ),
    cardTheme: CardThemeData(
      color: surface,
      surfaceTintColor: Colors.white,
      shadowColor: const Color(0xFF0F172A).withValues(alpha: 0.06),
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
        color: Color(0xFF0F172A),
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.2,
        color: Color(0xFF0F172A),
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xFF0F172A),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.5,
        color: Color(0xFF334155),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.45,
        color: Color(0xFF475569),
      ),
    ),
  );
}