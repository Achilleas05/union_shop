import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  testWidgets('App loads and displays header', (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Verify header elements are present
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
    expect(find.text('SALE!'), findsOneWidget);
    expect(find.text('PRINT SHACK'), findsOneWidget);
  });

  testWidgets('Home page displays featured products',
      (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    expect(find.text('FEATURED PRODUCTS'), findsOneWidget);
    expect(find.text('Portsmouth City Magnet'), findsOneWidget);
    expect(find.text('University Hoodie Navy'), findsOneWidget);
  });

  testWidgets('Navigation buttons work correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Test About navigation
    await tester.tap(find.text('About'));
    await tester.pumpAndSettle();
    expect(find.text('About us'), findsOneWidget);

    // Navigate back to home
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.text('FEATURED PRODUCTS'), findsOneWidget);
  });

  testWidgets('Print Shack dropdown works', (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Tap the Print Shack dropdown
    await tester.tap(find.text('PRINT SHACK'));
    await tester.pumpAndSettle();

    // Verify dropdown items
    expect(find.text('About Print Shack'), findsOneWidget);
    expect(find.text('Personalisation'), findsOneWidget);

    // Navigate to About Print Shack
    await tester.tap(find.text('About Print Shack'));
    await tester.pumpAndSettle();
    expect(find.text('About Print Shack'), findsAtLeastNWidgets(1));
  });

  testWidgets('Print Shack about page displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Navigate to Print Shack About
    await tester.tap(find.text('PRINT SHACK'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('About Print Shack'));
    await tester.pumpAndSettle();

    expect(find.text('About Print Shack'), findsAtLeastNWidgets(1));
    expect(
        find.text('Welcome to Print Shack - your personalization destination!'),
        findsOneWidget);
    expect(find.text('Our Services'), findsOneWidget);
    expect(find.text('Custom Text Printing'), findsOneWidget);
  });

  testWidgets('Print Shack personalisation page displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Navigate to Print Shack Personalisation
    await tester.tap(find.text('PRINT SHACK'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Personalisation'));
    await tester.pumpAndSettle();

    expect(find.text('Personalise Text'), findsOneWidget);
    expect(find.text('LINES AND LOCATION'), findsOneWidget);
    expect(find.text('ADD TO CART • £3.00'), findsOneWidget);
  });

  testWidgets('Mobile menu includes all navigation options',
      (WidgetTester tester) async {
    // Set smaller screen size for mobile
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Open mobile menu
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify all menu items
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
    expect(find.text('SALE!'), findsOneWidget);
    expect(find.text('About Print Shack'), findsOneWidget);
    expect(find.text('Personalisation'), findsOneWidget);
  });

  testWidgets('Cart icon is visible in header', (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
  });

  testWidgets('Search icon is visible in header', (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Banner displays sale message', (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('BIG SALE!'), findsOneWidget);
    expect(find.textContaining('OVER 20% OFF!'), findsOneWidget);
  });
}
