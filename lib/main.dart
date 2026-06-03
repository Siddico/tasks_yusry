import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const BasicNavigationApp());
}

class BasicNavigationApp extends StatelessWidget {
  const BasicNavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basic Navigation App',
      theme: buildAppTheme(),
      home: const SplashScreen(),
    );
  }
}
