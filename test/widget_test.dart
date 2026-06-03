import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:yusry/main.dart';

void main() {
  testWidgets('renders static local data list', (WidgetTester tester) async {
    await tester.pumpWidget(const StaticDataApp());

    expect(find.text('Static Data Showcase'), findsOneWidget);
    expect(find.text('Project Planning'), findsOneWidget);
    expect(find.text('Design Review'), findsOneWidget);
    expect(find.text('Development'), findsOneWidget);
    expect(find.text('Quality Check'), findsOneWidget);

    await tester.dragUntilVisible(
      find.text('Client Handover'),
      find.byType(ListView),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();

    expect(find.text('Client Handover'), findsOneWidget);
  });
}
