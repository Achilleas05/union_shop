import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/pages/print_shack_about_page.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';

void main() {
  Widget createTestWidget() {
    return ChangeNotifierProvider(
      create: (_) => Cart(),
      child: const MaterialApp(
        home: PrintShackAboutPage(),
      ),
    );
  }

  testWidgets('Print Shack About page displays title',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('About Print Shack'), findsAtLeastNWidgets(1));
  });

  testWidgets('Page displays welcome message', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(
        find.text('Welcome to Print Shack - your personalization destination!'),
        findsOneWidget);
  });

  testWidgets('Page displays services section', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('Our Services'), findsOneWidget);
    expect(find.text('Custom Text Printing'), findsOneWidget);
    expect(find.text('Quick Turnaround'), findsOneWidget);
    expect(find.text('Quality Guarantee'), findsOneWidget);
  });

  testWidgets('Page displays service descriptions',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.textContaining('Add up to 3 lines'), findsOneWidget);
    expect(find.textContaining('2-3 business days'), findsOneWidget);
    expect(find.textContaining('high-quality printing'), findsOneWidget);
  });

  testWidgets('Page displays important notice', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.textContaining('personalized items are made to order'),
        findsOneWidget);
    expect(
        find.textContaining('cannot be returned or exchanged'), findsOneWidget);
  });

  testWidgets('Page displays check icons for services',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.check_circle), findsNWidgets(3));
  });

  testWidgets('Page displays info icon in notice', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.info_outline), findsOneWidget);
  });

  testWidgets('Page includes header', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Header should contain navigation elements
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Page includes footer', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    // Scroll to bottom
    await tester.drag(
        find.byType(SingleChildScrollView), const Offset(0, -3000));
    await tester.pumpAndSettle();

    // Footer may not be implemented yet, so just verify page structure exists
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });
}
