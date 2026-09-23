import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:key_value_table_demo/main.dart';

void main() {
  testWidgets('Smoke test & renders all cards and headers in narrow layout', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KeyValueTableDemoApp());

    expect(find.text('key_value_table Demo'), findsOneWidget);
    expect(find.text('Live Feature Gallery'), findsOneWidget);
    expect(find.text('Physician Profile'), findsOneWidget);
    expect(find.text('Order Summary'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Server Diagnostics'), 500);
    expect(find.text('Server Diagnostics'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('App Specifications'), 500);
    expect(find.text('App Specifications'), findsOneWidget);
  });

  testWidgets('Toggle theme mode switches light/dark icons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KeyValueTableDemoApp());

    // Initially light mode -> dark_mode_rounded icon is shown
    expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);
    expect(find.byIcon(Icons.light_mode_rounded), findsNothing);

    // Tap theme toggle button
    await tester.tap(find.byTooltip('Toggle Light/Dark Theme'));
    await tester.pumpAndSettle();

    // Now dark mode -> light_mode_rounded icon is shown
    expect(find.byIcon(Icons.light_mode_rounded), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode_rounded), findsNothing);
  });

  testWidgets('Renders adaptive wide layout on large screen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const KeyValueTableDemoApp());

    expect(find.text('Physician Profile'), findsOneWidget);
    expect(find.text('Order Summary'), findsOneWidget);
    expect(find.text('Server Diagnostics'), findsOneWidget);
    expect(find.text('App Specifications'), findsOneWidget);
  });

  testWidgets('Tap on Server Diagnostics row triggers SnackBar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KeyValueTableDemoApp());

    await tester.scrollUntilVisible(find.text('Cluster Node'), 500);
    await tester.tap(find.text('Cluster Node'));
    await tester.pump();

    expect(find.textContaining('Copied "Cluster Node"'), findsOneWidget);
  });
}
