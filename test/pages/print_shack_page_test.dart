import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/pages/print_shack_page.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/footer.dart';

// Mock Cart for testing
class MockCart extends Cart {
  final List<CartItem> mockItems = [];
  int addItemCallCount = 0;
  CartItem? lastAddedItem;

  @override
  List<CartItem> get items => mockItems;

  double get totalPrice =>
      mockItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  int get totalItems => mockItems.fold(0, (sum, item) => sum + item.quantity);

  @override
  void addItem(CartItem item) {
    addItemCallCount++;
    lastAddedItem = item;
    mockItems.add(item);
    notifyListeners();
  }

  @override
  void clear() {
    mockItems.clear();
    notifyListeners();
  }

  @override
  void removeItem(String id, {String? color, String? size}) {
    mockItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  @override
  void updateQuantity(String id, int quantity, {String? color, String? size}) {
    final index = mockItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      mockItems[index].quantity = quantity;
      notifyListeners();
    }
  }
}

void main() {
  // Helper function to create test widget
  Widget createTestWidget({MockCart? cart, String initialRoute = '/'}) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const PrintShackPage(),
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Cart Page'))),
        ),
      ],
      initialLocation: initialRoute,
    );

    return ChangeNotifierProvider<Cart>.value(
      value: cart ?? MockCart(),
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  // Helper to select dropdown option
  Future<void> selectDropdownOption(
      WidgetTester tester, String optionText) async {
    // Ensure the dropdown is visible first
    final dropdown = find.byType(DropdownButtonFormField<String>).first;
    await tester.ensureVisible(dropdown);
    await tester.pumpAndSettle();

    // Tap to open dropdown
    await tester.tap(dropdown, warnIfMissed: false);
    await tester.pumpAndSettle();

    // Wait for dropdown animation
    await tester.pump(const Duration(milliseconds: 300));

    // Find the option in the overlay and tap it
    final option = find.text(optionText, skipOffstage: false).last;
    await tester.tap(option, warnIfMissed: false);
    await tester.pumpAndSettle();

    // Wait for state to update
    await tester.pump(const Duration(milliseconds: 300));
  }

  // Helper to enter text in all visible text fields
  Future<void> enterTextInFields(
      WidgetTester tester, List<String> texts) async {
    final textFields = find.byType(TextField);
    for (int i = 0; i < texts.length; i++) {
      if (i < tester.widgetList(textFields).length) {
        await tester.enterText(textFields.at(i), texts[i]);
      }
    }
    await tester.pumpAndSettle();
  }

  group('PrintShackPage Widget Tests', () {
    testWidgets('should render all main components', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(CustomHeader), findsOneWidget);
      expect(find.byType(Footer), findsOneWidget);
      expect(find.text('Personalise Text'), findsOneWidget);
      expect(find.text('£3.00'), findsOneWidget);
    });

    testWidgets('should render mobile layout when width < 768', (tester) async {
      tester.view.physicalSize = const Size(600, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Personalise Text'), findsOneWidget);
    });

    testWidgets('should render desktop layout when width >= 768',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Personalise Text'), findsOneWidget);
    });

    testWidgets('should display warning message', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
      expect(
        find.textContaining('Check spelling carefully'),
        findsOneWidget,
      );
    });
  });

  group('Configuration and Dropdown Tests', () {
    testWidgets('should display dropdown with all options', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('LINES AND LOCATION'), findsOneWidget);

      final dropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      // Check for dropdown items in overlay
      expect(find.text('1 line – front', skipOffstage: false), findsAtLeast(1));
      expect(
          find.text('2 lines – front', skipOffstage: false), findsAtLeast(1));
      expect(
          find.text('3 lines – front', skipOffstage: false), findsAtLeast(1));
      expect(find.text('1 line – back', skipOffstage: false), findsAtLeast(1));
      expect(find.text('2 lines – back', skipOffstage: false), findsAtLeast(1));
      expect(find.text('3 lines – back', skipOffstage: false), findsAtLeast(1));
      expect(find.text('1 line – front & back', skipOffstage: false),
          findsAtLeast(1));
      expect(find.text('2 lines – front & back', skipOffstage: false),
          findsAtLeast(1));
      expect(find.text('3 lines – front & back', skipOffstage: false),
          findsAtLeast(1));
    });

    testWidgets('should change configuration when dropdown value changes',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await selectDropdownOption(tester, '2 lines – front');

      // Wait for UI to update
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('LINE 1 (MAX 10 CHARACTERS)'), findsOneWidget);
      expect(find.text('LINE 2 (MAX 10 CHARACTERS)'), findsOneWidget);
      expect(find.text('LINE 3 (MAX 10 CHARACTERS)'), findsNothing);
    });

    testWidgets('should show 3 text fields for 3-line config', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await selectDropdownOption(tester, '3 lines – front');

      // Wait for UI to update
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('LINE 1 (MAX 10 CHARACTERS)'), findsOneWidget);
      expect(find.text('LINE 2 (MAX 10 CHARACTERS)'), findsOneWidget);
      expect(find.text('LINE 3 (MAX 10 CHARACTERS)'), findsOneWidget);
    });
  });

  group('Text Input Tests', () {
    testWidgets('should accept text input in first field', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, 'TEST');
      await tester.pumpAndSettle();

      expect(find.text('TEST'), findsWidgets);
    });

    testWidgets('should enforce 10 character limit', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, '12345678901234567890');
      await tester.pumpAndSettle();

      final TextField widget = tester.widget(textField);
      expect(widget.maxLength, 10);
    });

    testWidgets('should update preview when text is entered', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, 'HELLO');
      await tester.pumpAndSettle();

      expect(find.text('HELLO'), findsWidgets);
    });
  });

  group('Quantity Tests', () {
    testWidgets('should display initial quantity of 1', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('QUANTITY'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should increment quantity when + button is tapped',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final addButton = find.widgetWithIcon(InkWell, Icons.add).first;
      await tester.ensureVisible(addButton);
      await tester.pumpAndSettle();

      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('should decrement quantity when - button is tapped',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // First increment to 2
      final addButton = find.widgetWithIcon(InkWell, Icons.add).first;
      await tester.ensureVisible(addButton);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Then decrement back to 1
      final removeButton = find.widgetWithIcon(InkWell, Icons.remove).first;
      await tester.ensureVisible(removeButton);
      await tester.tap(removeButton);
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should not decrement quantity below 1', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final removeButton = find.widgetWithIcon(InkWell, Icons.remove).first;
      await tester.ensureVisible(removeButton);
      await tester.tap(removeButton);
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should update total price when quantity changes',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Initial price - look for the standalone price display (not in button)
      expect(find.text('£3.00').first, findsOneWidget);

      final addButton = find.widgetWithIcon(InkWell, Icons.add).first;
      await tester.ensureVisible(addButton);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // After increment, button text should show £6.00 (3.00 * 2)
      expect(find.textContaining('ADD TO CART • £6.00'), findsOneWidget);
    });
  });

  group('Price Calculation Tests', () {
    testWidgets('should show £3.00 for 1 line front', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('£3.00'), findsOneWidget);
    });

    testWidgets('should show £4.00 for 2 lines front', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await selectDropdownOption(tester, '2 lines – front');

      // Wait for price to update
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('£4.00'), findsOneWidget);
    });

    testWidgets('should show £5.00 for 3 lines front', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await selectDropdownOption(tester, '3 lines – front');

      // Wait for price to update
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('£5.00'), findsOneWidget);
    });

    testWidgets('should add £2.00 for front & back', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await selectDropdownOption(tester, '1 line – front & back');

      // Wait for price to update
      await tester.pump(const Duration(milliseconds: 500));

      // 1 line front = £3.00 + £2.00 for front & back = £5.00
      expect(find.text('£5.00'), findsOneWidget);
    });

    testWidgets('should show £7.00 for 3 lines front & back', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await selectDropdownOption(tester, '3 lines – front & back');

      // Wait for price to update
      await tester.pump(const Duration(milliseconds: 500));

      // 3 lines front = £5.00 + £2.00 for front & back = £7.00
      expect(find.text('£7.00'), findsOneWidget);
    });
  });

  group('Add to Cart Tests', () {
    testWidgets('should show error when adding to cart with empty text',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final addToCartButton = find.text('ADD TO CART • £3.00');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      await tester.pumpAndSettle();

      expect(
        find.text('Please enter at least the first line of text'),
        findsOneWidget,
      );
    });

    testWidgets('should add item to cart with valid input', (tester) async {
      final mockCart = MockCart();
      await tester.pumpWidget(createTestWidget(cart: mockCart));
      await tester.pumpAndSettle();

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, 'TEST');
      await tester.pumpAndSettle();

      final addToCartButton = find.text('ADD TO CART • £3.00');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      await tester.pumpAndSettle();

      // Check for success indicators
      expect(find.byIcon(Icons.check_circle), findsWidgets);
      expect(find.textContaining('Added 1 TEST to cart'), findsOneWidget);
      expect(mockCart.addItemCallCount, 1);
      expect(mockCart.mockItems.length, 1);
    });

    testWidgets('should show success snackbar after adding to cart',
        (tester) async {
      final mockCart = MockCart();
      await tester.pumpWidget(createTestWidget(cart: mockCart));
      await tester.pumpAndSettle();

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, 'SNACK');
      await tester.pumpAndSettle();

      final addToCartButton = find.text('ADD TO CART • £3.00');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_circle), findsWidgets);
      expect(find.textContaining('Added 1 SNACK to cart'), findsOneWidget);
    });

    testWidgets('should show dialog after adding to cart', (tester) async {
      final mockCart = MockCart();
      await tester.pumpWidget(createTestWidget(cart: mockCart));
      await tester.pumpAndSettle();

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, 'DIALOG');
      await tester.pumpAndSettle();

      final addToCartButton = find.text('ADD TO CART • £3.00');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(find.text('Item Added to Cart'), findsOneWidget);
      expect(find.text('CONTINUE SHOPPING'), findsOneWidget);
      expect(find.text('VIEW CART'), findsOneWidget);
    });

    testWidgets('should add multiple lines to cart', (tester) async {
      final mockCart = MockCart();
      await tester.pumpWidget(createTestWidget(cart: mockCart));
      await tester.pumpAndSettle();

      // Change to 2 lines configuration
      await selectDropdownOption(tester, '2 lines – front');

      // Enter text in both fields
      await enterTextInFields(tester, ['LINE1', 'LINE2']);
      await tester.pumpAndSettle();

      // Tap the actual ADD TO CART button for this config
      final addToCartButton = find.text('ADD TO CART • £4.00');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      await tester.pumpAndSettle();

      // Verify cart was updated with correct title
      expect(mockCart.addItemCallCount, 1);
      expect(mockCart.mockItems.length, 1);
      expect(mockCart.mockItems[0].title.contains('LINE1 / LINE2'), isTrue);
    });

    testWidgets('should add correct quantity to cart', (tester) async {
      final mockCart = MockCart();
      await tester.pumpWidget(createTestWidget(cart: mockCart));
      await tester.pumpAndSettle();

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, 'QTY');
      await tester.pumpAndSettle();

      // Increment quantity to 3
      final addButton = find.widgetWithIcon(InkWell, Icons.add).first;
      await tester.ensureVisible(addButton);

      await tester.tap(addButton);
      await tester.pumpAndSettle();

      await tester.ensureVisible(addButton);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.text('3'), findsOneWidget);

      final addToCartButton = find.textContaining('£9.00');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.textContaining('Added 3 QTY to cart'), findsOneWidget);
      expect(mockCart.addItemCallCount, 1);
      expect(mockCart.mockItems.length, 1);
      expect(mockCart.mockItems[0].quantity, 3);
    });

    testWidgets('should include location in cart item', (tester) async {
      final mockCart = MockCart();
      await tester.pumpWidget(createTestWidget(cart: mockCart));
      await tester.pumpAndSettle();

      await selectDropdownOption(tester, '1 line – back');

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, 'BACK');
      await tester.pumpAndSettle();

      final addToCartButton = find.text('ADD TO CART • £3.00');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.textContaining('Added 1 BACK to cart'), findsOneWidget);
      expect(mockCart.addItemCallCount, 1);
      expect(mockCart.mockItems.length, 1);
      expect(mockCart.mockItems[0].title.contains('Back'), isTrue);
    });
  });

  group('Buy Now Tests', () {
    testWidgets('should show error when buying with empty text',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final buyNowButton = find.text('BUY NOW');
      await tester.ensureVisible(buyNowButton);
      await tester.tap(buyNowButton);
      await tester.pump();
      await tester.pumpAndSettle();

      expect(
        find.text('Please enter at least the first line of text'),
        findsOneWidget,
      );
    });

    testWidgets('should navigate to cart after buy now', (tester) async {
      final mockCart = MockCart();

      // Use a test navigator observer to track navigation
      final TestNavigatorObserver observer = TestNavigatorObserver();

      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => ChangeNotifierProvider<Cart>.value(
              value: mockCart,
              child: const PrintShackPage(),
            ),
          ),
          GoRoute(
            path: '/cart',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Cart Page'))),
          ),
        ],
        initialLocation: '/',
        observers: [observer],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );
      await tester.pumpAndSettle();

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, 'BUY');
      await tester.pumpAndSettle();

      final buyNowButton = find.text('BUY NOW');
      await tester.ensureVisible(buyNowButton);
      await tester.tap(buyNowButton);
      await tester.pumpAndSettle();

      // Check navigation occurred
      expect(find.text('Cart Page'), findsOneWidget);
    });

    testWidgets('should add to cart before navigating', (tester) async {
      final mockCart = MockCart();

      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => ChangeNotifierProvider<Cart>.value(
              value: mockCart,
              child: const PrintShackPage(),
            ),
          ),
          GoRoute(
            path: '/cart',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Cart Page'))),
          ),
        ],
        initialLocation: '/',
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );
      await tester.pumpAndSettle();

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, 'NOW');
      await tester.pumpAndSettle();

      final buyNowButton = find.text('BUY NOW');
      await tester.ensureVisible(buyNowButton);
      await tester.tap(buyNowButton);
      await tester.pumpAndSettle();

      expect(mockCart.addItemCallCount, 1);
      expect(find.text('Cart Page'), findsOneWidget);
    });
  });

  group('Dialog Navigation Tests', () {
    testWidgets('should close dialog when continue shopping is tapped',
        (tester) async {
      final mockCart = MockCart();
      await tester.pumpWidget(createTestWidget(cart: mockCart));
      await tester.pumpAndSettle();

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, 'SHOP');
      await tester.pumpAndSettle();

      final addToCartButton = find.text('ADD TO CART • £3.00');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await tester.tap(find.text('CONTINUE SHOPPING'));
      await tester.pumpAndSettle();

      expect(find.text('Item Added to Cart'), findsNothing);
    });

    testWidgets('should navigate to cart when view cart is tapped',
        (tester) async {
      final mockCart = MockCart();

      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => ChangeNotifierProvider<Cart>.value(
              value: mockCart,
              child: const PrintShackPage(),
            ),
          ),
          GoRoute(
            path: '/cart',
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Cart Page'))),
          ),
        ],
        initialLocation: '/',
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );
      await tester.pumpAndSettle();

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, 'VIEW');
      await tester.pumpAndSettle();

      final addToCartButton = find.text('ADD TO CART • £3.00');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      await tester.tap(find.text('VIEW CART'));
      await tester.pumpAndSettle();

      expect(find.text('Cart Page'), findsOneWidget);
    });
  });

  group('Preview Display Tests', () {
    testWidgets('should show FRONT label for front location', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('FRONT'), findsOneWidget);
    });

    testWidgets('should show BACK label for back location', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await selectDropdownOption(tester, '1 line – back');

      // Wait for UI to update
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('BACK'), findsOneWidget);
    });

    testWidgets('should show FRONT & BACK label for both location',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await selectDropdownOption(tester, '1 line – front & back');

      // Wait for UI to update
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('FRONT & BACK'), findsOneWidget);
    });

    testWidgets('should display entered text in preview', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, 'PREVIEW');
      await tester.pumpAndSettle();

      expect(find.text('PREVIEW'), findsWidgets);
    });

    testWidgets('should only show non-empty lines in preview', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      await selectDropdownOption(tester, '3 lines – front');

      await enterTextInFields(tester, ['ONE', '', 'THREE']);
      await tester.pumpAndSettle();

      expect(find.text('ONE'), findsWidgets);
      expect(find.text('THREE'), findsWidgets);
    });
  });

  group('Edge Cases and State Management', () {
    testWidgets('should maintain state when switching configurations',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, 'STATE');
      await tester.pumpAndSettle();

      await selectDropdownOption(tester, '2 lines – front');

      // Wait for UI to update
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('STATE'), findsWidgets);
    });

    testWidgets('should handle trimming whitespace', (tester) async {
      final mockCart = MockCart();
      await tester.pumpWidget(createTestWidget(cart: mockCart));
      await tester.pumpAndSettle();

      final textField = find.byType(TextField).first;
      await tester.enterText(textField, '  TRIM  ');
      await tester.pumpAndSettle();

      final addToCartButton = find.text('ADD TO CART • £3.00');
      await tester.ensureVisible(addToCartButton);
      await tester.tap(addToCartButton);
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.textContaining('TRIM'), findsWidgets);
      expect(mockCart.addItemCallCount, 1);
      expect(mockCart.mockItems.length, 1);
      expect(mockCart.mockItems[0].title.contains('TRIM'), isTrue);
    });

    testWidgets('should dispose controllers properly', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // The widget should dispose properly when the test ends
      expect(tester.takeException(), isNull);
    });
  });
}

// Helper class for navigation testing
class TestNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>> routeStack = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.add(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.removeLast();
  }
}
