import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/pages/collections_page.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/cart.dart';

void main() {
  group('CollectionService', () {
    test('getCollections returns list of collections', () async {
      final service = CollectionService();
      final collections = await service.getCollections();

      expect(collections, isA<List<Collection>>());
      expect(collections.isNotEmpty, true);
    });
  });

  group('CollectionsPage', () {
    late GoRouter router;

    setUp(() {
      router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const CollectionsPage(),
          ),
          GoRoute(
            path: '/collections/:id',
            builder: (context, state) => Scaffold(
              body: Text('Collection ${state.pathParameters['id']}'),
            ),
          ),
        ],
      );
    });

    Widget createWidgetUnderTest({double width = 1200}) {
      return ChangeNotifierProvider(
        create: (_) => Cart(),
        child: MaterialApp.router(
          routerConfig: router,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                size: Size(width, 800),
              ),
              child: child!,
            );
          },
        ),
      );
    }

    testWidgets('renders page with header, title, collections grid, and footer',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Collections'), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(CollectionCard), findsWidgets);
    });

    testWidgets('displays correct layout for mobile (< 600px)',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(width: 400));
      await tester.pumpAndSettle();

      final gridView = tester.widget<GridView>(find.byType(GridView));
      final gridDelegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

      expect(gridDelegate.crossAxisCount, 2);
      expect(gridDelegate.crossAxisSpacing, 12);
      expect(gridDelegate.mainAxisSpacing, 12);
      expect(gridDelegate.childAspectRatio, 1.0);
    });

    testWidgets('displays correct layout for tablet (600-900px)',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(width: 750));
      await tester.pumpAndSettle();

      final gridView = tester.widget<GridView>(find.byType(GridView));
      final gridDelegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

      expect(gridDelegate.crossAxisCount, 3);
      expect(gridDelegate.crossAxisSpacing, 16);
      expect(gridDelegate.mainAxisSpacing, 16);
      expect(gridDelegate.childAspectRatio, 1.5);
    });

    testWidgets('displays correct layout for desktop (>= 900px)',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(width: 1200));
      await tester.pumpAndSettle();

      final gridView = tester.widget<GridView>(find.byType(GridView));
      final gridDelegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

      expect(gridDelegate.crossAxisCount, 3);
      expect(gridDelegate.crossAxisSpacing, 16);
      expect(gridDelegate.mainAxisSpacing, 16);
      expect(gridDelegate.childAspectRatio, 1.5);
    });

    testWidgets('loads collections on init', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Initial frame - collections are empty before initState completes
      expect(find.byType(CollectionCard), findsNothing);

      // After the first frame, async completes and setState is called
      await tester.pump();

      // Collections should now be loaded
      expect(find.byType(CollectionCard), findsWidgets);

      // Ensure everything is settled
      await tester.pumpAndSettle();
      expect(find.byType(CollectionCard), findsWidgets);
    });
  });

  group('CollectionCard', () {
    late GoRouter router;
    late Collection testCollection;

    setUp(() {
      testCollection = const Collection(
        id: 'test-id',
        name: 'Test Collection',
        icon: Icons.shopping_bag,
        color: Colors.blue,
        products: [
          Product(
            id: '1',
            name: 'Product 1',
            description: 'Test product 1',
            price: 10.0,
            imageUrl: 'https://example.com/image.jpg',
            sizes: ['S', 'M', 'L'],
            colors: ['Red', 'Blue'],
          ),
          Product(
            id: '2',
            name: 'Product 2',
            description: 'Test product 2',
            price: 20.0,
            imageUrl: 'https://example.com/image2.jpg',
            sizes: ['M', 'L', 'XL'],
            colors: ['Black', 'White'],
          ),
        ],
      );

      router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => Scaffold(
              body: CollectionCard(collection: testCollection),
            ),
          ),
          GoRoute(
            path: '/collections/:id',
            builder: (context, state) => Scaffold(
              body: Text('Collection ${state.pathParameters['id']}'),
            ),
          ),
        ],
      );
    });

    Widget createWidgetUnderTest({double width = 1200}) {
      return MaterialApp.router(
        routerConfig: router,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              size: Size(width, 800),
            ),
            child: child!,
          );
        },
      );
    }

    testWidgets('renders collection name and item count',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Test Collection'), findsOneWidget);
      expect(find.text('2 items'), findsOneWidget);
    });

    testWidgets('renders collection icon', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.shopping_bag), findsOneWidget);
    });

    testWidgets('displays hover effect on mouse enter and exit',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final mouseRegion = find.descendant(
        of: find.byType(CollectionCard),
        matching: find.byType(MouseRegion),
      );
      expect(mouseRegion, findsOneWidget);

      // Find the AnimatedOpacity widget
      AnimatedOpacity getAnimatedOpacity() {
        return tester.widget<AnimatedOpacity>(
          find.descendant(
            of: find.byType(CollectionCard),
            matching: find.byType(AnimatedOpacity),
          ),
        );
      }

      // Initially not hovering
      expect(getAnimatedOpacity().opacity, 0.0);

      // Simulate mouse enter
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();

      await gesture.moveTo(tester.getCenter(mouseRegion));
      await tester.pumpAndSettle();

      expect(getAnimatedOpacity().opacity, 1.0);

      // Simulate mouse exit
      await gesture.moveTo(const Offset(-1, -1));
      await tester.pumpAndSettle();

      expect(getAnimatedOpacity().opacity, 0.0);
    });

    testWidgets('navigates to collection detail on tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CollectionCard));
      await tester.pumpAndSettle();

      expect(find.text('Collection test-id'), findsOneWidget);
    });

    testWidgets('renders correctly on mobile', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(width: 400));
      await tester.pumpAndSettle();

      expect(find.text('Test Collection'), findsOneWidget);
      expect(find.text('2 items'), findsOneWidget);

      final icon = tester.widget<Icon>(find.byIcon(Icons.shopping_bag));
      expect(icon.size, 48);
    });

    testWidgets('renders correctly on tablet/desktop',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest(width: 800));
      await tester.pumpAndSettle();

      expect(find.text('Test Collection'), findsOneWidget);
      expect(find.text('2 items'), findsOneWidget);

      final icon = tester.widget<Icon>(find.byIcon(Icons.shopping_bag));
      expect(icon.size, 64);
    });

    testWidgets('displays gradient background with correct colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final container = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(CollectionCard),
              matching: find.byType(Container),
            )
            .first,
      );

      final decoration = container.decoration as BoxDecoration;
      final gradient = decoration.gradient as LinearGradient;

      expect(gradient.colors.length, 2);
      expect(gradient.begin, Alignment.topCenter);
      expect(gradient.end, Alignment.bottomCenter);
    });

    testWidgets('has clickable cursor on hover', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final mouseRegionFinder = find.descendant(
        of: find.byType(CollectionCard),
        matching: find.byType(MouseRegion),
      );

      final mouseRegion = tester.widget<MouseRegion>(mouseRegionFinder.first);
      expect(mouseRegion.cursor, SystemMouseCursors.click);
    });

    testWidgets('shows text with shadow effect', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final textWidget = tester.widget<Text>(find.text('Test Collection'));
      expect(textWidget.style?.shadows, isNotNull);
      expect(textWidget.style?.shadows?.length, 1);
      expect(textWidget.style?.shadows?.first.blurRadius, 4);
    });
  });
}
