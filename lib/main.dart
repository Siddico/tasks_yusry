// ============================================================
// main.dart
// Application entry point — Home Services App
// Initializes themes and routes to the login screen
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants/app_styles.dart';
import 'screens/login_screen.dart';

void main() {
  // Ensure Flutter bindings are initialized before any platform calls
  WidgetsFlutterBinding.ensureInitialized();

  // Lock app to portrait mode for consistent mobile UX
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Configure system UI overlay (transparent status bar)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  runApp(const HomeServicesApp());
}

/// Root application widget.
///
/// Configures Material Design 3 themes (light & dark) and
/// starts the app on the [LoginScreen].
class HomeServicesApp extends StatelessWidget {
  const HomeServicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ── App Metadata ───────────────────────────────────
      title: 'HomeServe — Home Services App',
      debugShowCheckedModeBanner: false,

      // ── Themes ─────────────────────────────────────────
      theme: AppStyles.lightTheme,
      darkTheme: AppStyles.darkTheme,
      themeMode: ThemeMode.system, // Follows system setting

      // ── Entry Point ────────────────────────────────────
      home: const LoginScreen(),

      // ── Global Page Transitions ────────────────────────
      // Smooth fade transition between routes
      onGenerateRoute: (settings) {
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}
