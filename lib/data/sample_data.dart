import 'package:flutter/material.dart';

import '../models/item_model.dart';

// Static local data keeps the app fully offline and focused on UI/navigation.
const List<ItemModel> sampleItems = [
  ItemModel(
    id: 'planning',
    title: 'Project Planning',
    shortDescription: 'Organize milestones and maintain a clear delivery path.',
    description:
        'A well-defined plan creates alignment, reduces uncertainty, and helps every milestone stay on track from start to finish.',
    icon: Icons.event_note_rounded,
    accentColor: Color(0xFF155EEF),
    category: 'Strategy',
    highlight: 'Focused execution',
  ),
  ItemModel(
    id: 'design',
    title: 'Design Review',
    shortDescription: 'Refine interface details and improve the overall polish.',
    description:
        'Design review ensures spacing, hierarchy, and visual balance all work together to create a premium mobile experience.',
    icon: Icons.design_services_rounded,
    accentColor: Color(0xFF0F766E),
    category: 'UI/UX',
    highlight: 'Pixel polish',
  ),
  ItemModel(
    id: 'development',
    title: 'Development',
    shortDescription: 'Build clean, maintainable code with reusable widgets.',
    description:
        'Development is structured around maintainability, readability, and reusable components so future updates remain simple.',
    icon: Icons.code_rounded,
    accentColor: Color(0xFF7C3AED),
    category: 'Build',
    highlight: 'Reusable architecture',
  ),
  ItemModel(
    id: 'qa',
    title: 'Quality Check',
    shortDescription: 'Verify responsiveness, spacing, and user flow.',
    description:
        'Quality checks help confirm the app behaves consistently across screen sizes while preserving the intended visual hierarchy.',
    icon: Icons.verified_rounded,
    accentColor: Color(0xFFF59E0B),
    category: 'Testing',
    highlight: 'Responsive validation',
  ),
  ItemModel(
    id: 'handover',
    title: 'Client Handover',
    shortDescription: 'Prepare a polished, submission-ready final package.',
    description:
        'The final handover includes clear documentation, a tidy structure, and a production-ready presentation that is easy to review.',
    icon: Icons.rocket_launch_rounded,
    accentColor: Color(0xFFEF4444),
    category: 'Delivery',
    highlight: 'Submission ready',
  ),
];