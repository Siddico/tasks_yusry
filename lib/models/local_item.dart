import 'package:flutter/material.dart';

class LocalItem {
  const LocalItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;
}
