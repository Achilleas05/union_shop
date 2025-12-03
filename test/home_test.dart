import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/header.dart';

// Helper function to create testable widget with providers
Widget createTestableWidget(Widget child) {
  return ChangeNotifierProvider(
    create: (_) => Cart(),
    child: child,
  );
}

void main() {
  group('Home Page Tests', () {
    testWidgets('should display home page with basic elements', (tester) async {
      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      // Check that basic UI elements are present
      expect(
        find.text('Essential Range - Over 20% OFF!'),
        findsOneWidget,
      );
      expect(
        find.text(
            'Over 20% off our Essential Range. Come and grab yours while stock lasts!'),
        findsOneWidget,
      );
      expect(find.text('FEATURED PRODUCTS'), findsOneWidget);
      expect(find.text('BROWSE COLLECTION'), findsOneWidget);
    });

    testWidgets('should display product cards', (tester) async {
      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      // Check that product cards are displayed
      expect(find.text('Portsmouth City Magnet'), findsOneWidget);
      expect(find.text('University Hoodie Navy'), findsOneWidget);
      expect(find.text('Pom Pom Beanie'), findsOneWidget);
      expect(find.text('UPSU Tote Bag'), findsOneWidget);

      // Check prices are displayed
      expect(find.text('£3.50'), findsOneWidget);
      expect(find.text('£29.99'), findsOneWidget);
      expect(find.text('£12.00'), findsOneWidget);
      expect(find.text('£6.00'), findsOneWidget);
    });

    testWidgets('should display header icons', (tester) async {
      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      // Check that header is present
      expect(find.byType(CustomHeader), findsOneWidget);
    });

    testWidgets('should display footer', (tester) async {
      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      // Check that footer is present (update with actual footer text from Footer widget)
      expect(find.byType(Footer), findsOneWidget);
    });

    testWidgets(
        'should navigate to collections when BROWSE COLLECTION button is tapped',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      // Tap the BROWSE COLLECTION button
      await tester.tap(find.text('BROWSE COLLECTION'));
      await tester.pumpAndSettle();

      // Verify navigation occurred (home page hero section should not be present)
      expect(find.text('Essential Range - Over 20% OFF!'), findsNothing);
    });

    testWidgets('should navigate to product page when product card is tapped',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      // Drag to scroll down to reveal product cards
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -500));
      await tester.pumpAndSettle();

      // Tap on the first product card
      await tester.tap(find.text('Portsmouth City Magnet').first);
      await tester.pumpAndSettle();

      // Verify navigation occurred by checking we're no longer on home page
      expect(find.text('BROWSE COLLECTION'), findsNothing);
    });

    testWidgets('should display correct layout on mobile size', (tester) async {
      // Set small screen size for mobile
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      // Check that hero text is present
      expect(find.text('Essential Range - Over 20% OFF!'), findsOneWidget);

      // Verify GridView has 1 column for mobile
      final gridView = tester.widget<GridView>(find.byType(GridView));
      final gridDelegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(gridDelegate.crossAxisCount, 1);

      addTearDown(tester.view.reset);
    });

    testWidgets('should display correct layout on desktop size',
        (tester) async {
      // Set large screen size for desktop
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      // Verify GridView has 2 columns for desktop
      final gridView = tester.widget<GridView>(find.byType(GridView));
      final gridDelegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(gridDelegate.crossAxisCount, 2);

      addTearDown(tester.view.reset);
    });

    testWidgets('should have SingleChildScrollView for scrolling',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('should navigate to different product pages', (tester) async {
      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      // Scroll down to reveal products
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -500));
      await tester.pumpAndSettle();

      // Tap hoodie product
      await tester.tap(find.text('University Hoodie Navy').first);
      await tester.pumpAndSettle();
      expect(find.text('BROWSE COLLECTION'), findsNothing);
    });

    testWidgets('should test HomeScreen navigation methods', (tester) async {
      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      final homeScreen = tester.widget<HomeScreen>(find.byType(HomeScreen));
      final context = tester.element(find.byType(HomeScreen));

      // Test navigateToHome - should stay on home
      homeScreen.navigateToHome(context);
      await tester.pumpAndSettle();
      expect(find.text('FEATURED PRODUCTS'), findsOneWidget);
    });

    testWidgets('should navigate to about page', (tester) async {
      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      final homeScreen = tester.widget<HomeScreen>(find.byType(HomeScreen));
      final context = tester.element(find.byType(HomeScreen));

      // Test navigateToAbout
      homeScreen.navigateToAbout(context);
      await tester.pumpAndSettle();
      expect(find.text('FEATURED PRODUCTS'), findsNothing);
    });

    testWidgets('should navigate to product page', (tester) async {
      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      final homeScreen = tester.widget<HomeScreen>(find.byType(HomeScreen));
      final context = tester.element(find.byType(HomeScreen));

      // Test navigateToProduct
      homeScreen.navigateToProduct(context);
      await tester.pumpAndSettle();
      expect(find.text('FEATURED PRODUCTS'), findsNothing);
    });

    testWidgets('should navigate to collections page', (tester) async {
      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      final homeScreen = tester.widget<HomeScreen>(find.byType(HomeScreen));
      final context = tester.element(find.byType(HomeScreen));

      // Test navigateToCollections
      homeScreen.navigateToCollections(context);
      await tester.pumpAndSettle();
      expect(find.text('FEATURED PRODUCTS'), findsNothing);
    });

    testWidgets('should test ProductCard tap gesture', (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const Scaffold(
              body: SizedBox(
                height: 400,
                width: 300,
                child: ProductCard(
                  title: 'Test Product',
                  price: '£10.00',
                  imageUrl: 'assets/test.png',
                  productId: 'test-1',
                ),
              ),
            ),
          ),
          GoRoute(
            path: '/product/:productId',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('Product Page')),
            ),
          ),
        ],
        initialLocation: '/',
      );

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => Cart(),
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      // Find and tap the ProductCard
      await tester.tap(find.byType(ProductCard));
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(find.text('Product Page'), findsOneWidget);
    });

    testWidgets('should render hero section with correct styling',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const UnionShopApp()));
      await tester.pumpAndSettle();

      // Check Stack widget exists
      expect(find.byType(Stack), findsWidgets);

      // Check Container with background exists
      final containers = tester.widgetList<Container>(find.byType(Container));
      expect(containers.isNotEmpty, true);
    });
  });
}
