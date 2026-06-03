import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yusry/main.dart';

void main() {
  testWidgets('renders splash and home content', (WidgetTester tester) async {
    await tester.pumpWidget(const BasicNavigationApp());

    expect(find.text('Basic Navigation App'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1800));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to the App'), findsOneWidget);
    expect(find.text('Featured Items'), findsOneWidget);
    expect(find.text('Project Planning'), findsOneWidget);
    expect(find.text('Design Review'), findsOneWidget);
    expect(find.text('Development'), findsOneWidget);

    await tester.tap(find.text('Project Planning'));
    await tester.pumpAndSettle();
    expect(find.text('Item Details'), findsOneWidget);
    expect(find.text('Back to Home'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
      find.text('Quality Check'),
      find.byType(CustomScrollView),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();

    expect(find.text('Quality Check'), findsOneWidget);

    await tester.dragUntilVisible(
      find.text('Client Handover'),
      find.byType(CustomScrollView),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();

    expect(find.text('Client Handover'), findsOneWidget);
  });
}
