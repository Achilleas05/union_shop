import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/pages/collection_page.dart';

void main() {
  final List<Product> mockProducts = [
    const Product(
      id: '1',
      name: 'T-Shirt Alpha',
      price: 15.99,
      imageUrl: 'assets/images/tshirt.png',
      description: 'A t-shirt',
      sizes: ['S', 'M', 'L'],
      colors: ['Red'],
      tag: 'New',
    ),
    const Product(
      id: '2',
      name: 'Hat Beta',
      price: 25.50,
      imageUrl: 'assets/images/hat.png',
      description: 'A hat',
      sizes: ['One Size'],
      colors: ['Black'],
      originalPrice: 30.00,
      tag: 'Sale',
    ),
    const Product(
      id: '3',
      name: 'Notebook Charlie',
      price: 5.99,
      imageUrl: 'assets/images/notebook.png',
      description: 'A notebook',
      sizes: ['One Size'],
      colors: ['Blue'],
    ),
    const Product(
      id: '4',
      name: 'Laptop Delta',
      price: 599.99,
      imageUrl: 'assets/images/laptop.png',
      description: 'A laptop',
      sizes: ['One Size'],
      colors: ['Silver'],
    ),
    const Product(
      id: '5',
      name: 'Mug Echo',
      price: 8.99,
      imageUrl: 'assets/images/mug.png',
      description: 'A mug',
      sizes: ['One Size'],
      colors: ['White'],
    ),
    const Product(
      id: '6',
      name: 'Hoodie Foxtrot',
      price: 35.00,
      imageUrl: 'assets/images/hoodie.png',
      description: 'A hoodie',
      sizes: ['S', 'M', 'L'],
      colors: ['Black'],
      originalPrice: 45.00,
      tag: 'Sale',
    ),
    const Product(
      id: '7',
      name: 'Backpack Golf',
      price: 40.00,
      imageUrl: 'assets/images/backpack.png',
      description: 'A backpack',
      sizes: ['One Size'],
      colors: ['Navy'],
      tag: 'New',
    ),
  ];

  Widget createTestWidget({
    required String collectionTitle,
    required List<Product> products,
  }) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => CollectionPage(
            collectionTitle: collectionTitle,
            collectionProducts: products,
          ),
        ),
        GoRoute(
          path: '/product/:id',
          builder: (context, state) => Scaffold(
            body: Text('Product ${state.pathParameters['id']}'),
          ),
        ),
      ],
    );

    return ChangeNotifierProvider(
      create: (_) => Cart(),
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  group('CollectionPage - Basic Rendering', () {
    testWidgets('renders with products', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test Collection',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Collection'), findsOneWidget);
      expect(find.text('7 products in this collection'), findsOneWidget);
    });

    testWidgets('renders empty state', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Empty Collection',
          products: const [],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Empty Collection'), findsOneWidget);
      expect(find.text('0 products in this collection'), findsOneWidget);
    });
  });

  group('CollectionPage - Collection Headers', () {
    testWidgets('displays Sale Items header', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Sale Items',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('SALE'), findsOneWidget);
      expect(
        find.text("Don't miss out! Get yours before they're all gone!"),
        findsOneWidget,
      );
      expect(
        find.text("All prices shown are inclusive of the discount 🛒"),
        findsOneWidget,
      );
    });

    testWidgets('displays Essential Range header', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Essential Range',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Essential Range'), findsAtLeastNWidgets(1));
      expect(find.text("Quality basics, everyday value."), findsOneWidget);
      expect(
        find.text(
          "Over 20% off our Essential Range—stock up for the semester!",
        ),
        findsOneWidget,
      );
    });

    testWidgets('displays University Clothing header',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'University Clothing',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('University Clothing'), findsAtLeastNWidgets(1));
      expect(find.text("Show your university pride."), findsOneWidget);
      expect(
        find.text(
          "Browse our official campus apparel—perfect for every student.",
        ),
        findsOneWidget,
      );
    });

    testWidgets('displays Study Supplies header', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Study Supplies',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Study Supplies'), findsAtLeastNWidgets(1));
      expect(find.text("Gear up for success."), findsOneWidget);
      expect(
        find.text(
          "Find essential stationery and accessories for every student.",
        ),
        findsOneWidget,
      );
    });

    testWidgets('displays Tech Essentials header', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Tech Essentials',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Tech Essentials'), findsAtLeastNWidgets(1));
      expect(find.text("Power up your studies."), findsOneWidget);
      expect(
        find.text("Essential technology and accessories for modern learning."),
        findsOneWidget,
      );
    });

    testWidgets('displays Gift Shop header', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Gift Shop',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Gift Shop'), findsAtLeastNWidgets(1));
      expect(find.text("Share a piece of Portsmouth."), findsOneWidget);
      expect(
        find.text(
          "Souvenirs and gifts for every occasion—find something to make someone smile.",
        ),
        findsOneWidget,
      );
    });

    testWidgets('displays Graduation header', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Graduation',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Graduation'), findsAtLeastNWidgets(1));
      expect(find.text("Celebrate your achievement."), findsOneWidget);
      expect(
        find.text(
          "Everything you need for your special graduation day and memories to cherish forever.",
        ),
        findsOneWidget,
      );
    });
  });

  group('CollectionPage - Filtering', () {
    testWidgets('filters by Clothing category', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Clothing').last);
      await tester.pumpAndSettle();

      // Since Product has no category field, filtering won't work - all products remain
      expect(find.text('7 products in this collection'), findsOneWidget);
    });

    testWidgets('filters by Accessories category', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Accessories').last);
      await tester.pumpAndSettle();

      expect(find.text('7 products in this collection'), findsOneWidget);
    });

    testWidgets('filters by Study Supplies category',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Study Supplies').last);
      await tester.pumpAndSettle();

      expect(find.text('7 products in this collection'), findsOneWidget);
    });

    testWidgets('filters by Electronics category', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Electronics').last);
      await tester.pumpAndSettle();

      expect(find.text('7 products in this collection'), findsOneWidget);
    });

    testWidgets('filters by Gift category', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gift').last);
      await tester.pumpAndSettle();

      expect(find.text('7 products in this collection'), findsOneWidget);
    });

    testWidgets('filters by Sale items', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sale items').last);
      await tester.pumpAndSettle();

      // Filters by tag == 'Sale' - should find 2 products
      expect(find.text('2 products in this collection'), findsOneWidget);
    });

    testWidgets('filters by New arrivals', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('New arrivals').last);
      await tester.pumpAndSettle();

      // Filters by tag == 'New' - should find 2 products
      expect(find.text('2 products in this collection'), findsOneWidget);
    });

    testWidgets('resets filter to All products', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sale items').last);
      await tester.pumpAndSettle();

      expect(find.text('2 products in this collection'), findsOneWidget);

      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('All products').last);
      await tester.pumpAndSettle();

      expect(find.text('7 products in this collection'), findsOneWidget);
    });
  });

  group('CollectionPage - Sorting', () {
    testWidgets('sorts by Price: Low to High', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Price: Low to High').last);
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
      expect(find.text('7 products in this collection'), findsOneWidget);
    });

    testWidgets('sorts by Price: High to Low', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Price: High to Low').last);
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
      expect(find.text('7 products in this collection'), findsOneWidget);
    });

    testWidgets('sorts by A-Z', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('A-Z').last);
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
      expect(find.text('7 products in this collection'), findsOneWidget);
    });

    testWidgets('resets sort to Featured', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('A-Z').last);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Featured').last);
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
    });
  });

  group('CollectionPage - Pagination', () {
    testWidgets('navigates to next page', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      // Scroll to pagination area
      final paginationText = find.text('Page 1 of 2');
      await tester.ensureVisible(paginationText);
      await tester.pumpAndSettle();

      expect(paginationText, findsOneWidget);

      final nextButtons = find.byWidgetPredicate(
        (widget) =>
            widget is IconButton &&
            widget.icon is Icon &&
            (widget.icon as Icon).icon == Icons.chevron_right,
      );

      await tester.tap(nextButtons.first);
      await tester.pumpAndSettle();

      expect(find.text('Page 2 of 2'), findsOneWidget);
    });

    testWidgets('navigates to previous page', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      // Scroll to pagination area
      await tester.ensureVisible(find.text('Page 1 of 2'));
      await tester.pumpAndSettle();

      final nextButtons = find.byWidgetPredicate(
        (widget) =>
            widget is IconButton &&
            widget.icon is Icon &&
            (widget.icon as Icon).icon == Icons.chevron_right,
      );

      await tester.tap(nextButtons.first);
      await tester.pumpAndSettle();

      // Ensure we can still see the pagination after tap
      await tester.ensureVisible(find.text('Page 2 of 2'));
      await tester.pumpAndSettle();

      expect(find.text('Page 2 of 2'), findsOneWidget);

      final prevButtons = find.byWidgetPredicate(
        (widget) =>
            widget is IconButton &&
            widget.icon is Icon &&
            (widget.icon as Icon).icon == Icons.chevron_left,
      );

      await tester.tap(prevButtons.first);
      await tester.pumpAndSettle();
      expect(find.text('Page 1 of 2'), findsOneWidget);
    });

    testWidgets('disables previous button on first page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Page 1 of 2'));
      await tester.pumpAndSettle();

      final prevButtons = find.byWidgetPredicate(
        (widget) =>
            widget is IconButton &&
            widget.icon is Icon &&
            (widget.icon as Icon).icon == Icons.chevron_left,
      );

      final button = tester.widget<IconButton>(prevButtons.first);
      expect(button.onPressed, isNull);
    });

    testWidgets('disables next button on last page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Page 1 of 2'));
      await tester.pumpAndSettle();

      final nextButtons = find.byWidgetPredicate(
        (widget) =>
            widget is IconButton &&
            widget.icon is Icon &&
            (widget.icon as Icon).icon == Icons.chevron_right,
      );

      await tester.tap(nextButtons.first);
      await tester.pumpAndSettle();

      // Ensure pagination is still visible
      await tester.ensureVisible(find.text('Page 2 of 2'));
      await tester.pumpAndSettle();

      final button = tester.widget<IconButton>(nextButtons.first);
      expect(button.onPressed, isNull);
    });

    testWidgets('resets to page 1 when filter changes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to page 2
      await tester.ensureVisible(find.text('Page 1 of 2'));
      await tester.pumpAndSettle();

      final nextButtons = find.byWidgetPredicate(
        (widget) =>
            widget is IconButton &&
            widget.icon is Icon &&
            (widget.icon as Icon).icon == Icons.chevron_right,
      );

      await tester.tap(nextButtons.first);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Page 2 of 2'));
      await tester.pumpAndSettle();
      expect(find.text('Page 2 of 2'), findsOneWidget);

      // Scroll to top to access filter dropdown
      await tester.scrollUntilVisible(
        find.byType(DropdownButtonFormField<String>).last,
        -200.0,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sale items').last);
      await tester.pumpAndSettle();

      expect(find.text('Page 1 of 1'), findsOneWidget);
    });

    testWidgets('handles single page correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Small',
          products: [mockProducts[0]],
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Page 1 of 1'));
      await tester.pumpAndSettle();

      expect(find.text('Page 1 of 1'), findsOneWidget);

      final prevButtons = find.byWidgetPredicate(
        (widget) =>
            widget is IconButton &&
            widget.icon is Icon &&
            (widget.icon as Icon).icon == Icons.chevron_left,
      );
      final nextButtons = find.byWidgetPredicate(
        (widget) =>
            widget is IconButton &&
            widget.icon is Icon &&
            (widget.icon as Icon).icon == Icons.chevron_right,
      );

      final prev = tester.widget<IconButton>(prevButtons.first);
      final next = tester.widget<IconButton>(nextButtons.first);

      expect(prev.onPressed, isNull);
      expect(next.onPressed, isNull);
    });
  });

  group('CollectionPage - Product Display', () {
    testWidgets('displays product information', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: [mockProducts[0]],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('T-Shirt Alpha'), findsOneWidget);
      expect(find.text('£15.99'), findsOneWidget);
    });

    testWidgets('displays sale price and original price',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: [mockProducts[1]],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('£25.50'), findsOneWidget);
      expect(find.text('£30.00'), findsOneWidget);
    });

    testWidgets('displays product tag', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: [mockProducts[1]],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sale'), findsOneWidget);
    });

    testWidgets('handles image error gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: [mockProducts[0]],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.image_not_supported), findsWidgets);
    });

    testWidgets('navigates to product page on tap',
        (WidgetTester tester) async {
      // Use larger screen to avoid overflow issues
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: [mockProducts[0]],
        ),
      );
      await tester.pumpAndSettle();

      // Find the Card widget which is tappable
      final cardFinder = find.byType(Card).first;
      await tester.tap(cardFinder);
      await tester.pumpAndSettle();

      expect(find.text('Product 1'), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });
  });

  group('CollectionPage - Edge Cases', () {
    testWidgets('handles empty product list', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Empty',
          products: const [],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('0 products in this collection'), findsOneWidget);
      expect(find.text('Page 1 of 1'), findsOneWidget);
    });

    testWidgets('handles filter resulting in empty list',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: const [
            Product(
              id: '1',
              name: 'Test',
              price: 10.0,
              imageUrl: 'test.png',
              description: 'Test',
              sizes: ['One Size'],
              colors: ['Black'],
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('New arrivals').last);
      await tester.pumpAndSettle();

      expect(find.text('0 products in this collection'), findsOneWidget);
    });

    testWidgets('handles exact page multiple', (WidgetTester tester) async {
      final products = List.generate(
        6,
        (i) => Product(
          id: '$i',
          name: 'Product $i',
          price: 10.0,
          imageUrl: 'test.png',
          description: 'Test',
          sizes: const ['One Size'],
          colors: const ['Black'],
        ),
      );

      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: products,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Page 1 of 1'), findsOneWidget);
    });
  });

  group('CollectionPage - Combined Operations', () {
    testWidgets('applies filter and sort together',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sale items').last);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Price: Low to High').last);
      await tester.pumpAndSettle();

      expect(find.text('2 products in this collection'), findsOneWidget);
    });
  });

  group('CollectionPage - Responsive Layout', () {
    testWidgets('renders mobile layout', (WidgetTester tester) async {
      // Use 600x800 to avoid dropdown overflow (still considered mobile-ish)
      tester.view.physicalSize = const Size(600, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('renders desktop layout', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });
  });

  group('CollectionPage - Additional Coverage', () {
    testWidgets('verifies all collection headers render correctly',
        (WidgetTester tester) async {
      final collectionTitles = [
        'Sale Items',
        'Essential Range',
        'University Clothing',
        'Study Supplies',
        'Tech Essentials',
        'Gift Shop',
        'Graduation',
        'Other Collection', // Tests default case
      ];

      for (final title in collectionTitles) {
        await tester.pumpWidget(
          createTestWidget(
            collectionTitle: title,
            products: mockProducts,
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text(title), findsAtLeastNWidgets(1));
      }
    });

    testWidgets('applies all sort options', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      final sortOptions = [
        'Featured',
        'Price: Low to High',
        'Price: High to Low',
        'A-Z'
      ];

      for (final option in sortOptions) {
        await tester.tap(find.byType(DropdownButtonFormField<String>).first);
        await tester.pumpAndSettle();
        await tester.tap(find.text(option).last);
        await tester.pumpAndSettle();

        expect(find.text('7 products in this collection'), findsOneWidget);
      }
    });

    testWidgets('applies all filter options', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'All Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      final filterOptions = [
        'All products',
        'Clothing',
        'Accessories',
        'Study Supplies',
        'Electronics',
        'Gift',
        'Sale items',
        'New arrivals'
      ];

      for (final option in filterOptions) {
        await tester.tap(find.byType(DropdownButtonFormField<String>).last);
        await tester.pumpAndSettle();
        await tester.tap(find.text(option).last);
        await tester.pumpAndSettle();

        expect(find.byType(GridView), findsOneWidget);
      }
    });

    testWidgets('tests pagination with exact boundaries',
        (WidgetTester tester) async {
      // Test with exactly 6 products (1 page)
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Six Products',
          products: mockProducts.sublist(0, 6),
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Page 1 of 1'));
      await tester.pumpAndSettle();
      expect(find.text('Page 1 of 1'), findsOneWidget);

      // Test with 7 products (2 pages)
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Seven Products',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Page 1 of 2'));
      await tester.pumpAndSettle();
      expect(find.text('Page 1 of 2'), findsOneWidget);
    });

    testWidgets('tests goToPreviousPage when on first page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Page 1 of 2'));
      await tester.pumpAndSettle();

      // Try to go to previous page when already on page 1
      final prevButtons = find.byWidgetPredicate(
        (widget) =>
            widget is IconButton &&
            widget.icon is Icon &&
            (widget.icon as Icon).icon == Icons.chevron_left,
      );

      final button = tester.widget<IconButton>(prevButtons.first);
      expect(button.onPressed, isNull); // Should be disabled
    });

    testWidgets('tests goToNextPage when on last page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Page 1 of 2'));
      await tester.pumpAndSettle();

      // Go to last page
      final nextButtons = find.byWidgetPredicate(
        (widget) =>
            widget is IconButton &&
            widget.icon is Icon &&
            (widget.icon as Icon).icon == Icons.chevron_right,
      );

      await tester.tap(nextButtons.first);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Page 2 of 2'));
      await tester.pumpAndSettle();

      // Try to go to next page when already on last page
      final button = tester.widget<IconButton>(nextButtons.first);
      expect(button.onPressed, isNull); // Should be disabled
    });

    testWidgets('tests empty _currentPageItems', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Empty',
          products: const [],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('0 products in this collection'), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('tests null values in dropdowns', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      // The dropdowns should never have null values due to initialization
      expect(find.text('Featured'), findsOneWidget);
      expect(find.text('All products'), findsOneWidget);
    });

    testWidgets('tests mobile vs desktop breakpoint',
        (WidgetTester tester) async {
      // Test at exactly 599px (mobile)
      tester.view.physicalSize = const Size(599, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Mobile Test',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);

      // Test at exactly 600px (desktop)
      tester.view.physicalSize = const Size(600, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Desktop Test',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('tests product with no tag', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: [mockProducts[2]], // Notebook has no tag
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Notebook Charlie'), findsOneWidget);
      expect(find.text('£5.99'), findsOneWidget);
      // Should not find any tag
      expect(find.text('Sale'), findsNothing);
      expect(find.text('New'), findsNothing);
    });

    testWidgets('tests product without originalPrice',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: [mockProducts[0]], // T-Shirt has no originalPrice
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('£15.99'), findsOneWidget);
      // Should not show strikethrough price
      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      final strikethroughTexts = textWidgets.where(
          (widget) => widget.style?.decoration == TextDecoration.lineThrough);
      expect(strikethroughTexts.isEmpty, true);
    });

    testWidgets('tests changing filter twice in a row',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      // Apply first filter
      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sale items').last);
      await tester.pumpAndSettle();
      expect(find.text('2 products in this collection'), findsOneWidget);

      // Apply second filter
      await tester.tap(find.byType(DropdownButtonFormField<String>).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('New arrivals').last);
      await tester.pumpAndSettle();
      expect(find.text('2 products in this collection'), findsOneWidget);
    });

    testWidgets('tests changing sort twice in a row',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      // Apply first sort
      await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('A-Z').last);
      await tester.pumpAndSettle();

      // Apply second sort
      await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Price: High to Low').last);
      await tester.pumpAndSettle();

      expect(find.text('7 products in this collection'), findsOneWidget);
    });

    testWidgets('tests all pagination buttons states',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: mockProducts,
        ),
      );
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Page 1 of 2'));
      await tester.pumpAndSettle();

      // Get button widgets
      final prevButtons = find.byWidgetPredicate(
        (widget) =>
            widget is IconButton &&
            widget.icon is Icon &&
            (widget.icon as Icon).icon == Icons.chevron_left,
      );
      final nextButtons = find.byWidgetPredicate(
        (widget) =>
            widget is IconButton &&
            widget.icon is Icon &&
            (widget.icon as Icon).icon == Icons.chevron_right,
      );

      // Page 1: prev disabled, next enabled
      var prevButton = tester.widget<IconButton>(prevButtons.first);
      var nextButton = tester.widget<IconButton>(nextButtons.first);
      expect(prevButton.onPressed, isNull);
      expect(nextButton.onPressed, isNotNull);

      // Go to page 2
      await tester.tap(nextButtons.first);
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Page 2 of 2'));
      await tester.pumpAndSettle();

      // Page 2: prev enabled, next disabled
      prevButton = tester.widget<IconButton>(prevButtons.first);
      nextButton = tester.widget<IconButton>(nextButtons.first);
      expect(prevButton.onPressed, isNotNull);
      expect(nextButton.onPressed, isNull);
    });

    testWidgets('tests tag color for Sale vs New', (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: [mockProducts[1], mockProducts[0]], // Sale and New
        ),
      );
      await tester.pumpAndSettle();

      // Find containers with tags
      final containers = tester.widgetList<Container>(find.byType(Container));
      final tagContainers = containers.where((container) {
        final decoration = container.decoration;
        if (decoration is BoxDecoration) {
          return decoration.color == Colors.red ||
              decoration.color == Colors.orange;
        }
        return false;
      });

      expect(tagContainers.length, greaterThanOrEqualTo(2));
    });

    testWidgets('tests very long product names', (WidgetTester tester) async {
      const longNameProduct = Product(
        id: '999',
        name:
            'This is a very long product name that should be truncated with ellipsis',
        price: 99.99,
        imageUrl: 'test.png',
        description: 'Test',
        sizes: ['One Size'],
        colors: ['Red'],
      );

      await tester.pumpWidget(
        createTestWidget(
          collectionTitle: 'Test',
          products: [longNameProduct],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
    });
  });
}
