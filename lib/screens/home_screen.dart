import 'package:flutter/material.dart';

import '../data/local_items.dart';
import '../widgets/item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Static Data Showcase')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Local Items',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A simple single-screen Flutter app powered by hardcoded local data.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF64748B),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                itemCount: localItems.length,
                itemBuilder: (context, index) {
                  final item = localItems[index];

                  // Each row is derived from a local hardcoded object so the app
                  // stays fully offline and easy to maintain.
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == localItems.length - 1 ? 0 : 14,
                    ),
                    child: ItemCard(item: item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
