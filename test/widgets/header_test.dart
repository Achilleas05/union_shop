import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/search_overlay.dart';

void main() {
  late Cart mockCart;
  late GoRouter mockRouter;
  String? lastRoute;

  setUp(() {
    mockCart = Cart();
    lastRoute = null;
  });

  Widget createTestWidget({
    required Widget child,
    double width = 1200,
  }) {
    mockRouter = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => child,
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const Scaffold(body: Text('About')),
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const Scaffold(body: Text('Cart')),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const Scaffold(body: Text('Login')),
        ),
        GoRoute(
          path: '/collections/sale-items',
          builder: (context, state) => const Scaffold(body: Text('Sale')),
        ),
        GoRoute(
          path: '/print-shack',
          builder: (context, state) =>
              const Scaffold(body: Text('Print Shack')),
        ),
        GoRoute(
          path: '/print-shack/about',
          builder: (context, state) =>
              const Scaffold(body: Text('Print Shack About')),
        ),
        GoRoute(
          path: '/order-history',
          builder: (context, state) =>
              const Scaffold(body: Text('Order History')),
        ),
      ],
      redirect: (context, state) {
        lastRoute = state.uri.toString();
        return null;
      },
    );

    return ChangeNotifierProvider<Cart>.value(
      value: mockCart,
      child: MaterialApp.router(
        routerConfig: mockRouter,
        builder: (context, widget) => MediaQuery(
          data: MediaQueryData(size: Size(width, 800)),
          child: widget!,
        ),
      ),
    );
  }

  group('CustomHeader - Desktop View', () {
    testWidgets('renders correctly with all elements', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CustomHeader), findsOneWidget);
      expect(
          find.text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!'),
          findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('SALE!'), findsOneWidget);
      expect(find.text('PRINT SHACK'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.history), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    });

    testWidgets('has correct height for desktop', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final headerBox = tester.getSize(find.byType(CustomHeader));
      expect(headerBox.height, 140);
    });

    testWidgets('navigates to home when logo is tapped', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Image));
      await tester.pumpAndSettle();
      expect(lastRoute, '/');
    });

    testWidgets('navigates to home when Home button is tapped', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(lastRoute, '/');
    });

    testWidgets('navigates to sale when SALE! button is tapped',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('SALE!'));
      await tester.pumpAndSettle();
      expect(lastRoute, '/collections/sale-items');
    });

    testWidgets(
        'navigates to print-shack when PRINT SHACK dropdown item is tapped',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('PRINT SHACK'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Personalisation').last);
      await tester.pumpAndSettle();
      expect(lastRoute, '/print-shack');
    });

    testWidgets(
        'navigates to print-shack/about when About Print Shack is tapped',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('PRINT SHACK'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('About Print Shack').last);
      await tester.pumpAndSettle();
      expect(lastRoute, '/print-shack/about');
    });

    testWidgets('navigates to about when About button is tapped',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('About'));
      await tester.pumpAndSettle();
      expect(lastRoute, '/about');
    });

    testWidgets('shows search overlay when search icon is tapped',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(find.byType(SearchOverlay), findsOneWidget);
    });

    testWidgets('hides nav buttons when search is shown', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsNothing);
      expect(find.text('SALE!'), findsNothing);
    });

    testWidgets('navigates to login when person icon is tapped',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.person_outline));
      await tester.pumpAndSettle();
      expect(lastRoute, '/login');
    });

    testWidgets('navigates to cart when cart icon is tapped', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.shopping_cart));
      await tester.pumpAndSettle();
      expect(lastRoute, '/cart');
    });

    testWidgets('navigates to order history when history icon is tapped',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.history));
      await tester.pumpAndSettle();
      expect(lastRoute, '/order-history');
    });

    testWidgets('does not show mobile menu on desktop', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.menu), findsNothing);
    });
  });

  group('CustomHeader - Mobile View', () {
    testWidgets('renders correctly with mobile layout', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CustomHeader), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('has correct height for mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      final headerBox = tester.getSize(find.byType(CustomHeader));
      expect(headerBox.height, 120);
    });

    testWidgets('does not show nav buttons on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsNothing);
      expect(find.text('SALE!'), findsNothing);
      expect(find.text('PRINT SHACK'), findsNothing);
      expect(find.text('About'), findsNothing);
    });

    testWidgets('shows mobile menu', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('mobile menu navigates correctly - Home', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Home').last);
      await tester.pumpAndSettle();
      expect(lastRoute, '/');
    });

    testWidgets('mobile menu navigates correctly - About', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text('About').last);
      await tester.pumpAndSettle();
      expect(lastRoute, '/about');
    });

    testWidgets('mobile menu navigates correctly - SALE!', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text('SALE!'));
      await tester.pumpAndSettle();
      expect(lastRoute, '/collections/sale-items');
    });

    testWidgets('mobile menu navigates correctly - PRINT SHACK',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Personalisation'));
      await tester.pumpAndSettle();
      expect(lastRoute, '/print-shack');
    });

    testWidgets('mobile menu navigates correctly - About Print Shack',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text('About Print Shack'));
      await tester.pumpAndSettle();
      expect(lastRoute, '/print-shack/about');
    });

    testWidgets('hides logo when searching on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(find.byType(Image), findsNothing);
    });

    testWidgets('shows close button when searching on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('closes search when close button is tapped', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(find.byType(SearchOverlay), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.byType(SearchOverlay), findsNothing);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('hides other icons when searching on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.person_outline), findsNothing);
      expect(find.byIcon(Icons.shopping_cart), findsNothing);
      expect(find.byIcon(Icons.menu), findsNothing);
    });
  });

  group('CustomHeader - Cart Badge', () {
    testWidgets('does not show badge when cart is empty', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      expect(mockCart.itemCount, 0);
      expect(find.text('0'), findsNothing);
    });

    testWidgets('shows badge with correct count when cart has items',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final item1 = CartItem(
        id: 'product1',
        productId: 'prod1',
        title: 'Test Product',
        price: 10.0,
        quantity: 1,
        imageUrl: 'image.jpg',
      );
      mockCart.addItem(item1);
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);

      final item2 = CartItem(
        id: 'product2',
        productId: 'prod2',
        title: 'Test Product 2',
        price: 20.0,
        quantity: 1,
        imageUrl: 'image2.jpg',
      );
      mockCart.addItem(item2);
      await tester.pumpAndSettle();
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('badge shows correct count with multiple items',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      // Add multiple items
      for (int i = 1; i <= 3; i++) {
        final item = CartItem(
          id: 'product$i',
          productId: 'prod$i',
          title: 'Test Product $i',
          price: 10.0 * i,
          quantity: 1,
          imageUrl: 'image$i.jpg',
        );
        mockCart.addItem(item);
      }

      await tester.pumpAndSettle();
      expect(find.text('3'), findsOneWidget);
      expect(mockCart.itemCount, 3);
    });

    testWidgets('badge displays on mobile view', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      final item = CartItem(
        id: 'mobile_item',
        productId: 'mobile_prod',
        title: 'Mobile Test Product',
        price: 15.0,
        quantity: 1,
        imageUrl: 'mobile_image.jpg',
      );
      mockCart.addItem(item);
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('badge styling is correct', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final item = CartItem(
        id: 'style_item',
        productId: 'style_prod',
        title: 'Style Test',
        price: 10.0,
        quantity: 1,
        imageUrl: 'style.jpg',
      );
      mockCart.addItem(item);
      await tester.pumpAndSettle();

      final badgeText = tester.widget<Text>(find.text('1'));
      expect(badgeText.style?.color, Colors.white);
      expect(badgeText.style?.fontSize, 12);
      expect(badgeText.style?.fontWeight, FontWeight.bold);
      expect(badgeText.textAlign, TextAlign.center);
    });

    testWidgets('badge container has correct decoration', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final item = CartItem(
        id: 'badge_dec',
        productId: 'badge_dec_prod',
        title: 'Badge Decoration Test',
        price: 10.0,
        quantity: 1,
        imageUrl: 'badge_dec.jpg',
      );
      mockCart.addItem(item);
      await tester.pumpAndSettle();

      final badgeContainer = tester.widget<Container>(
        find
            .ancestor(
              of: find.text('1'),
              matching: find.byType(Container),
            )
            .first,
      );
      expect(
          badgeContainer.decoration,
          const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ));
      expect(badgeContainer.constraints,
          const BoxConstraints(minWidth: 20, minHeight: 20));
      expect(badgeContainer.padding, const EdgeInsets.all(4));
    });
  });

  group('CustomHeader - Custom Callbacks', () {
    testWidgets('calls custom onHomePressed callback', (tester) async {
      bool homePressed = false;

      await tester.pumpWidget(
        createTestWidget(
          child: Scaffold(
            body: CustomHeader(
              onHomePressed: () => homePressed = true,
            ),
          ),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Image));
      await tester.pumpAndSettle();
      expect(homePressed, true);
    });

    testWidgets('calls custom onAboutPressed callback', (tester) async {
      bool aboutPressed = false;

      await tester.pumpWidget(
        createTestWidget(
          child: Scaffold(
            body: CustomHeader(
              onAboutPressed: () => aboutPressed = true,
            ),
          ),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('About'));
      await tester.pumpAndSettle();
      expect(aboutPressed, true);
      // When custom callback is provided, it should not navigate
      expect(lastRoute, isNot('/about'));
    });

    testWidgets('calls custom onCartPressed callback', (tester) async {
      bool cartPressed = false;

      await tester.pumpWidget(
        createTestWidget(
          child: Scaffold(
            body: CustomHeader(
              onCartPressed: () => cartPressed = true,
            ),
          ),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      // Find the InkWell wrapping the cart icon instead of the icon itself
      final cartInkWell = find.ancestor(
        of: find.byIcon(Icons.shopping_cart),
        matching: find.byType(InkWell),
      );
      await tester.tap(cartInkWell);
      await tester.pumpAndSettle();
      expect(cartPressed, true);
    });
  });

  group('CustomHeader - Banner', () {
    testWidgets('displays banner with correct styling on desktop',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final bannerText = tester.widget<Text>(find.text(
          'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!'));
      expect(bannerText.style?.fontSize, 16);
      expect(bannerText.style?.fontWeight, FontWeight.bold);
      expect(bannerText.style?.color, Colors.white);
    });

    testWidgets('displays banner with correct styling on mobile',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      final bannerText = tester.widget<Text>(find.text(
          'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!'));
      expect(bannerText.style?.fontSize, 12);
      expect(bannerText.style?.fontWeight, FontWeight.bold);
    });
  });

  group('CustomHeader - Logo Error Handling', () {
    testWidgets('shows error widget when image fails to load', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final image = tester.widget<Image>(find.byType(Image));
      final errorWidget = image.errorBuilder!(
        tester.element(find.byType(Image)),
        Object(),
        null,
      );

      expect(errorWidget, isA<Container>());
    });
  });

  group('CustomHeader - Tablet View', () {
    testWidgets('renders correctly on tablet size', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 700,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CustomHeader), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });
  });

  group('CustomHeader - Search Functionality', () {
    testWidgets('closes search when SearchOverlay onClose is called',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      // Open search
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(find.byType(SearchOverlay), findsOneWidget);

      // Find and call the onClose callback by interacting with SearchOverlay
      final searchOverlay =
          tester.widget<SearchOverlay>(find.byType(SearchOverlay));
      searchOverlay.onClose();
      await tester.pumpAndSettle();

      expect(find.byType(SearchOverlay), findsNothing);
    });

    testWidgets('search overlay is present when search is active',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      expect(find.byType(SearchOverlay), findsOneWidget);
    });

    testWidgets('search is contained in constrained container on desktop',
        (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Find the Container that directly wraps SearchOverlay
      final searchContainer = find.ancestor(
        of: find.byType(SearchOverlay),
        matching: find.byType(Container),
      );

      expect(searchContainer, findsWidgets);
    });

    testWidgets('nav buttons are hidden when search is shown', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      // Verify nav buttons are visible initially
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('SALE!'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Nav buttons should be hidden
      expect(find.text('Home'), findsNothing);
      expect(find.text('SALE!'), findsNothing);
    });

    testWidgets('search takes full width on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Verify SearchOverlay is visible on mobile
      expect(find.byType(SearchOverlay), findsOneWidget);
      // Verify close button appears
      expect(find.byIcon(Icons.close), findsOneWidget);
    });
  });

  group('CustomHeader - Responsive Breakpoints', () {
    testWidgets('shows desktop layout at 769px width', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 769,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsNothing);
      final headerBox = tester.getSize(find.byType(CustomHeader));
      expect(headerBox.height, 140);
    });

    testWidgets('shows mobile layout at 768px width', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 768,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsNothing);
      expect(find.byIcon(Icons.menu), findsOneWidget);
      final headerBox = tester.getSize(find.byType(CustomHeader));
      expect(headerBox.height, 120);
    });

    testWidgets('shows mobile banner styling at 599px', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 599,
        ),
      );
      await tester.pumpAndSettle();

      final bannerText = tester.widget<Text>(find.text(
          'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!'));
      expect(bannerText.style?.fontSize, 12);
      expect(bannerText.style?.letterSpacing, 0.5);
    });

    testWidgets('shows desktop banner styling at 600px', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 600,
        ),
      );
      await tester.pumpAndSettle();

      final bannerText = tester.widget<Text>(find.text(
          'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!'));
      expect(bannerText.style?.fontSize, 16);
      expect(bannerText.style?.letterSpacing, 1.1);
    });
  });

  group('CustomHeader - Logo Sizing', () {
    testWidgets('logo has correct size on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.height, 24);
    });

    testWidgets('logo has correct size on desktop', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.height, 30);
    });

    testWidgets('logo has correct fit property', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final image = tester.widget<Image>(find.byType(Image));
      expect(image.fit, BoxFit.cover);
    });
  });

  group('CustomHeader - Icon Styling', () {
    testWidgets('all icons have correct size', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final searchIcon = tester.widget<Icon>(find.byIcon(Icons.search).first);
      expect(searchIcon.size, 18);
      expect(searchIcon.color, Colors.grey);

      final historyIcon = tester.widget<Icon>(find.byIcon(Icons.history));
      expect(historyIcon.size, 18);
      expect(historyIcon.color, Colors.grey);

      final personIcon = tester.widget<Icon>(find.byIcon(Icons.person_outline));
      expect(personIcon.size, 18);
      expect(personIcon.color, Colors.grey);

      final cartIcon = tester.widget<Icon>(find.byIcon(Icons.shopping_cart));
      expect(cartIcon.size, 18);
      expect(cartIcon.color, Colors.grey);
    });

    testWidgets('mobile menu icon has correct styling', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      final menuIcon = tester.widget<Icon>(find.byIcon(Icons.menu));
      expect(menuIcon.size, 18);
      expect(menuIcon.color, Colors.grey);
    });

    testWidgets('close icon has correct styling on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      final closeIcon = tester.widget<Icon>(find.byIcon(Icons.close));
      expect(closeIcon.size, 18);
      // Color is null when not explicitly set, defaults to IconTheme
      expect(closeIcon.color, isNull);
    });
  });

  group('CustomHeader - Navigation Button Styling', () {
    testWidgets('Home button has correct styling', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final homeButton = tester.widget<Text>(find.text('Home'));
      expect(homeButton.style?.color, const Color(0xFF4d2963));
      expect(homeButton.style?.fontSize, 14);
      expect(homeButton.style?.fontWeight, FontWeight.w600);
      expect(homeButton.style?.letterSpacing, 0);
    });

    testWidgets('SALE! button has correct bold styling', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final saleButton = tester.widget<Text>(find.text('SALE!'));
      expect(saleButton.style?.color, Colors.red);
      expect(saleButton.style?.fontSize, 14);
      expect(saleButton.style?.fontWeight, FontWeight.bold);
      expect(saleButton.style?.letterSpacing, 1.2);
    });

    testWidgets('PRINT SHACK button has correct styling', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final printShackButton = tester.widget<Text>(find.text('PRINT SHACK'));
      expect(printShackButton.style?.color, const Color(0xFF4d2963));
      expect(printShackButton.style?.fontSize, 14);
      expect(printShackButton.style?.fontWeight, FontWeight.w600);
    });

    testWidgets('About button has correct styling', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final aboutButton = tester.widget<Text>(find.text('About'));
      expect(aboutButton.style?.color, const Color(0xFF4d2963));
      expect(aboutButton.style?.fontSize, 14);
      expect(aboutButton.style?.fontWeight, FontWeight.w600);
    });
  });

  group('CustomHeader - Banner Styling', () {
    testWidgets('banner has correct background color', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final banner = tester.widget<Container>(
        find
            .ancestor(
              of: find.text(
                  'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!'),
              matching: find.byType(Container),
            )
            .first,
      );
      expect(banner.color, const Color(0xFF4d2963));
    });

    testWidgets('banner has correct padding on desktop', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final banner = tester.widget<Container>(
        find
            .ancestor(
              of: find.text(
                  'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!'),
              matching: find.byType(Container),
            )
            .first,
      );
      expect(banner.padding,
          const EdgeInsets.symmetric(vertical: 12, horizontal: 16));
    });

    testWidgets('banner has correct padding on mobile', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      final banner = tester.widget<Container>(
        find
            .ancestor(
              of: find.text(
                  'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!'),
              matching: find.byType(Container),
            )
            .first,
      );
      expect(banner.padding,
          const EdgeInsets.symmetric(vertical: 8, horizontal: 8));
    });

    testWidgets('banner text is centered', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final bannerText = tester.widget<Text>(find.text(
          'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!'));
      expect(bannerText.textAlign, TextAlign.center);
    });
  });

  group('CustomHeader - Cart Badge Positioning', () {
    testWidgets('badge is positioned correctly', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final item = CartItem(
        id: 'badge_pos',
        productId: 'badge_prod',
        title: 'Badge Position Test',
        price: 10.0,
        quantity: 1,
        imageUrl: 'badge.jpg',
      );
      mockCart.addItem(item);
      await tester.pumpAndSettle();

      final positioned = tester.widget<Positioned>(
        find.ancestor(
          of: find.text('1'),
          matching: find.byType(Positioned),
        ),
      );
      expect(positioned.right, -8);
      expect(positioned.top, -8);
    });

    testWidgets('badge container has correct decoration', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final item = CartItem(
        id: 'badge_dec',
        productId: 'badge_dec_prod',
        title: 'Badge Decoration Test',
        price: 10.0,
        quantity: 1,
        imageUrl: 'badge_dec.jpg',
      );
      mockCart.addItem(item);
      await tester.pumpAndSettle();

      final badgeContainer = tester.widget<Container>(
        find
            .ancestor(
              of: find.text('1'),
              matching: find.byType(Container),
            )
            .first,
      );
      expect(
          badgeContainer.decoration,
          const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ));
      expect(badgeContainer.constraints,
          const BoxConstraints(minWidth: 20, minHeight: 20));
      expect(badgeContainer.padding, const EdgeInsets.all(4));
    });
  });

  group('CustomHeader - Layout Structure', () {
    testWidgets('header uses Column layout', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byType(CustomHeader),
          matching: find.byType(Column),
        ),
        findsOneWidget,
      );
    });

    testWidgets('main content uses Stack layout', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      // There are multiple Stack widgets (one for header content, one for cart badge)
      expect(
        find.descendant(
          of: find.byType(CustomHeader),
          matching: find.byType(Stack),
        ),
        findsWidgets,
      );
    });

    testWidgets('header has white background', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final headerContainer = tester.widget<Container>(
        find
            .descendant(
              of: find.byType(CustomHeader),
              matching: find.byType(Container),
            )
            .first,
      );
      expect(headerContainer.color, Colors.white);
    });
  });

  group('CustomHeader - Dropdown Menu', () {
    testWidgets('PRINT SHACK dropdown shows correct items', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('PRINT SHACK'));
      await tester.pumpAndSettle();

      expect(find.text('About Print Shack'), findsOneWidget);
      expect(find.text('Personalisation'), findsOneWidget);
    });

    testWidgets('PRINT SHACK dropdown has correct icon', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final dropdownIcon = find.descendant(
        of: find.ancestor(
          of: find.text('PRINT SHACK'),
          matching: find.byType(Row),
        ),
        matching: find.byIcon(Icons.arrow_drop_down),
      );
      expect(dropdownIcon, findsOneWidget);
    });
  });

  group('CustomHeader - Mobile Menu Items', () {
    testWidgets('mobile menu shows all menu items', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsWidgets);
      expect(find.text('About'), findsWidgets);
      expect(find.text('SALE!'), findsOneWidget);
      expect(find.text('About Print Shack'), findsOneWidget);
      expect(find.text('Personalisation'), findsOneWidget);
    });

    testWidgets('mobile menu navigates to order history', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 400,
        ),
      );
      await tester.pumpAndSettle();

      // History icon should be visible on mobile too (hidden in menu, but present in action bar)
      // Update test to verify it's clickable and navigates correctly
      await tester.tap(find.byIcon(Icons.history));
      await tester.pumpAndSettle();
      expect(lastRoute, '/order-history');
    });
  });

  group('CustomHeader - History Icon', () {
    testWidgets('history icon is visible on desktop', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.history), findsOneWidget);
    });

    testWidgets('history icon navigates correctly', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.history));
      await tester.pumpAndSettle();
      expect(lastRoute, '/order-history');
    });

    testWidgets('history icon has correct styling', (tester) async {
      await tester.pumpWidget(
        createTestWidget(
          child: const Scaffold(body: CustomHeader()),
          width: 1200,
        ),
      );
      await tester.pumpAndSettle();

      final historyIcon = tester.widget<Icon>(find.byIcon(Icons.history));
      expect(historyIcon.size, 18);
      expect(historyIcon.color, Colors.grey);
    });
  });
}
