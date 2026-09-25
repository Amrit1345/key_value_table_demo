import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:key_value_table_demo/main.dart';

void main() {
  testWidgets('Smoke test & renders cards and headers in narrow layout', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KeyValueTableDemoApp());

    expect(find.text('key_value_table Showcase'), findsOneWidget);
    expect(find.text('Live Feature Gallery'), findsOneWidget);
    expect(find.text('1. Modern Clean Profile'), findsOneWidget);
    expect(find.text('2. Financial & Receipt'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('3. Form & Inspector Alignment'), 500);
    expect(find.text('3. Form & Inspector Alignment'), findsOneWidget);
  });

  testWidgets('Toggle theme mode switches light/dark icons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KeyValueTableDemoApp());

    // Initially dark mode -> light_mode_rounded icon is shown
    expect(find.byIcon(Icons.light_mode_rounded), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode_rounded), findsNothing);

    // Tap theme toggle button
    await tester.tap(find.byTooltip('Toggle Light/Dark Theme'));
    await tester.pumpAndSettle();

    // Now light mode -> dark_mode_rounded icon is shown
    expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);
    expect(find.byIcon(Icons.light_mode_rounded), findsNothing);
  });

  testWidgets('Renders adaptive wide layout on large screen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const KeyValueTableDemoApp());

    expect(find.text('1. Modern Clean Profile'), findsOneWidget);
    expect(find.text('2. Financial & Receipt'), findsOneWidget);
    expect(find.text('3. Form & Inspector Alignment'), findsOneWidget);
    expect(find.text('4. Diagnostics & Tap-to-Copy'), findsOneWidget);
  });
}
