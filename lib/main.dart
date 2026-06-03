import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const StaticDataApp());
}

class StaticDataApp extends StatelessWidget {
  const StaticDataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Static Data Showcase',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1D4ED8),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
      ),
      home: const HomeScreen(),
    );
  }
}
