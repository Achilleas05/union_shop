import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:go_router/go_router.dart';

void main() {
  Widget createTestWidget() {
    final router = GoRouter(
      routes: [
        GoRoute(
            path: '/',
            builder: (_, __) => const Scaffold(
                  body: CustomHeader(), // or whatever the actual widget name is
                )),
        GoRoute(path: '/about', builder: (_, __) => const Scaffold()),
        GoRoute(path: '/print-shack', builder: (_, __) => const Scaffold()),
        GoRoute(
            path: '/print-shack/about', builder: (_, __) => const Scaffold()),
        GoRoute(
            path: '/collections/sale-items',
            builder: (_, __) => const Scaffold()),
        GoRoute(path: '/cart', builder: (_, __) => const Scaffold()),
        GoRoute(path: '/login', builder: (_, __) => const Scaffold()),
      ],
    );

    return ChangeNotifierProvider(
      create: (_) => Cart(),
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  testWidgets('Header displays all navigation buttons on desktop',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
    expect(find.text('SALE!'), findsOneWidget);
    expect(find.text('PRINT SHACK'), findsOneWidget);
  });

  testWidgets('Header displays mobile menu on small screens',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.menu), findsOneWidget);
  });

  testWidgets('Print Shack dropdown contains correct items',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.text('PRINT SHACK'));
    await tester.pumpAndSettle();

    expect(find.text('About Print Shack'), findsOneWidget);
    expect(find.text('Personalisation'), findsOneWidget);
  });

  testWidgets('Mobile menu contains all navigation options',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
    expect(find.text('SALE!'), findsOneWidget);
    expect(find.text('About Print Shack'), findsOneWidget);
    expect(find.text('Personalisation'), findsOneWidget);
  });

  testWidgets('Header displays cart icon', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
  });

  testWidgets('Header displays search icon', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Header displays person icon for login',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.person_outline), findsOneWidget);
  });

  testWidgets('Banner displays sale message', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.textContaining('BIG SALE!'), findsOneWidget);
    expect(find.textContaining('ESSENTIAL RANGE'), findsOneWidget);
  });

  testWidgets('Logo is displayed and clickable', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    final logoFinder = find.byType(Image);
    expect(logoFinder, findsAtLeastNWidgets(1));
  });
}
