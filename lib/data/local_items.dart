import 'package:flutter/material.dart';

import '../models/local_item.dart';

// Hardcoded local data used by the single-screen list.
const List<LocalItem> localItems = [
  LocalItem(
    title: 'Project Planning',
    description: 'Organize milestones and keep the delivery focused.',
    icon: Icons.event_note_rounded,
    accentColor: Color(0xFF1D4ED8),
  ),
  LocalItem(
    title: 'Design Review',
    description: 'Capture feedback early and keep the interface polished.',
    icon: Icons.design_services_rounded,
    accentColor: Color(0xFF0F766E),
  ),
  LocalItem(
    title: 'Development',
    description: 'Build with clean structure and maintainable Flutter code.',
    icon: Icons.code_rounded,
    accentColor: Color(0xFF7C3AED),
  ),
  LocalItem(
    title: 'Quality Check',
    description: 'Verify the UI, layout, and behavior before delivery.',
    icon: Icons.verified_rounded,
    accentColor: Color(0xFFB45309),
  ),
  LocalItem(
    title: 'Client Handover',
    description: 'Package the project so it can be reviewed and submitted.',
    icon: Icons.rocket_launch_rounded,
    accentColor: Color(0xFFDC2626),
  ),
];
