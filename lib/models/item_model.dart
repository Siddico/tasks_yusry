import 'package:flutter/material.dart';

class ItemModel {
  const ItemModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.category,
    required this.highlight,
  });

  final String id;
  final String title;
  final String shortDescription;
  final String description;
  final IconData icon;
  final Color accentColor;
  final String category;
  final String highlight;
}
