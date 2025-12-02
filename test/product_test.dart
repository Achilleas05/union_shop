import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/pages/product_page.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/footer.dart';

void main() {
  group('Product Page Tests', () {
    late Cart cart;

    setUp(() {
      cart = Cart();
    });

    Widget createTestWidget({Product? product}) {
      return ChangeNotifierProvider.value(
        value: cart,
        child: MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const Scaffold(body: Text('Home')),
              ),
              GoRoute(
                path: '/cart',
                builder: (context, state) => const Scaffold(body: Text('Cart')),
              ),
              GoRoute(
                path: '/product',
                builder: (context, state) => ProductPage(product: product),
              ),
            ],
            initialLocation: '/product',
          ),
        ),
      );
    }

    const testProduct = Product(
      id: 'test-1',
      name: 'Test Product',
      imageUrl: 'assets/test.png',
      price: 25.99,
      originalPrice: 35.99,
      tag: 'Sale',
      description: 'Test description',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Red', 'Blue', 'Green'],
    );

    testWidgets('should display product with all details', (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£25.99'), findsOneWidget);
      expect(find.text('£35.99'), findsOneWidget);
      expect(find.text('Sale'), findsOneWidget);
      expect(find.text('Test description'), findsOneWidget);
    });

    testWidgets('should display dummy product when no product provided',
        (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Classic Sweatshirt'), findsOneWidget);
      expect(find.text('£29.99'), findsOneWidget);
    });

    testWidgets('should display size dropdown with all sizes', (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      expect(find.text('Size:'), findsOneWidget);
      // Initial size should be 'S' (first in the list)
      expect(find.text('S'), findsOneWidget);

      await tester.tap(find.text('S'));
      await tester.pumpAndSettle();

      expect(find.text('M').hitTestable(), findsOneWidget);
      expect(find.text('L').hitTestable(), findsOneWidget);
      expect(find.text('XL').hitTestable(), findsOneWidget);
    });

    testWidgets('should display color dropdown with all colors',
        (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      expect(find.text('Color:'), findsOneWidget);
      expect(find.text('Red'), findsOneWidget);

      await tester.tap(find.text('Red'));
      await tester.pumpAndSettle();

      expect(find.text('Blue').hitTestable(), findsOneWidget);
      expect(find.text('Green').hitTestable(), findsOneWidget);
    });

    testWidgets('should change selected size', (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      await tester.tap(find.text('S'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('L').last);
      await tester.pumpAndSettle();

      expect(find.text('L'), findsOneWidget);
    });

    testWidgets('should change selected color', (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Red'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Blue').last);
      await tester.pumpAndSettle();

      expect(find.text('Blue'), findsOneWidget);
    });

    testWidgets('should increment quantity', (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      // Scroll to make the quantity selector visible
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -200));
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('should decrement quantity', (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      // Scroll to make the quantity selector visible
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -200));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.remove), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should not decrement quantity below 1', (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      // Scroll to make the quantity selector visible
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -200));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.remove), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should add item to cart', (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      // Scroll to make the ADD TO CART button visible
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      await tester.tap(find.text('ADD TO CART'));
      await tester.pumpAndSettle();

      expect(cart.itemCount, 1);
      expect(find.text('Item Added to Cart'), findsOneWidget);
      expect(
          find.text(
              'Your item has been successfully added to the shopping cart.'),
          findsOneWidget);
    });

    testWidgets('should add correct quantity to cart', (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      // Scroll to make the buttons visible
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -200));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -100));
      await tester.pumpAndSettle();

      await tester.tap(find.text('ADD TO CART'));
      await tester.pumpAndSettle();

      expect(cart.items[0].quantity, 3);
    });

    testWidgets('should show snackbar when item added to cart', (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      // Scroll to make the ADD TO CART button visible
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      await tester.tap(find.text('ADD TO CART'));
      await tester.pump();

      // Check for snackbar content - it shows both check icon and "Added" text
      expect(find.byIcon(Icons.check_circle), findsWidgets);
      expect(find.text('Added 1 Test Product to cart'), findsOneWidget);
    });

    testWidgets('should navigate to cart when VIEW CART clicked',
        (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      // Scroll to make the ADD TO CART button visible
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      await tester.tap(find.text('ADD TO CART'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('VIEW CART'));
      await tester.pumpAndSettle();

      expect(find.text('Cart'), findsOneWidget);
    });

    testWidgets('should close dialog when CONTINUE SHOPPING clicked',
        (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      // Scroll to make the ADD TO CART button visible
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      await tester.tap(find.text('ADD TO CART'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('CONTINUE SHOPPING'));
      await tester.pumpAndSettle();

      expect(find.text('Item Added to Cart'), findsNothing);
    });

    testWidgets('should navigate to home when Continue Shopping clicked',
        (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      // Scroll to make the Continue Shopping button visible
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue Shopping'));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('should add to cart and navigate on BUY NOW', (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      // Scroll to make the BUY NOW button visible
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      await tester.tap(find.text('BUY NOW'));
      await tester.pumpAndSettle();

      expect(cart.itemCount, 1);
      expect(find.text('Cart'), findsOneWidget);
    });

    testWidgets('should display header', (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      // Check that the header widget is present
      expect(find.byType(CustomHeader), findsOneWidget);
    });

    testWidgets('should display footer', (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      // Check that the footer widget is present
      expect(find.byType(Footer), findsOneWidget);
    });

    testWidgets('should not show size dropdown for One Size products',
        (tester) async {
      const oneSizeProduct = Product(
        id: 'test-2',
        name: 'One Size Product',
        imageUrl: 'assets/test.png',
        price: 15.00,
        description: 'One size fits all',
        sizes: ['One Size'],
        colors: ['Black'],
      );

      await tester.pumpWidget(createTestWidget(product: oneSizeProduct));
      await tester.pumpAndSettle();

      expect(find.text('Size:'), findsNothing);
    });

    testWidgets('should handle product without colors', (tester) async {
      const noColorProduct = Product(
        id: 'test-3',
        name: 'No Color Product',
        imageUrl: 'assets/test.png',
        price: 20.00,
        description: 'No color options',
        sizes: ['M', 'L'],
        colors: [],
      );

      await tester.pumpWidget(createTestWidget(product: noColorProduct));
      await tester.pumpAndSettle();

      expect(find.text('Color:'), findsNothing);
      expect(find.text('Size:'), findsOneWidget);
    });

    testWidgets('should handle product without tag', (tester) async {
      const noTagProduct = Product(
        id: 'test-4',
        name: 'Regular Product',
        imageUrl: 'assets/test.png',
        price: 30.00,
        description: 'Regular price',
        sizes: ['M'],
        colors: ['Black'],
      );

      await tester.pumpWidget(createTestWidget(product: noTagProduct));
      await tester.pumpAndSettle();

      expect(find.text('Sale'), findsNothing);
      expect(find.text('New'), findsNothing);
    });

    testWidgets('should display New tag correctly', (tester) async {
      const newProduct = Product(
        id: 'test-5',
        name: 'New Product',
        imageUrl: 'assets/test.png',
        price: 40.00,
        tag: 'New',
        description: 'Brand new',
        sizes: ['M'],
        colors: ['Black'],
      );

      await tester.pumpWidget(createTestWidget(product: newProduct));
      await tester.pumpAndSettle();

      expect(find.text('New'), findsOneWidget);
    });

    testWidgets('should handle empty description', (tester) async {
      const noDescProduct = Product(
        id: 'test-6',
        name: 'No Desc Product',
        imageUrl: 'assets/test.png',
        price: 25.00,
        description: '',
        sizes: ['M'],
        colors: ['Black'],
      );

      await tester.pumpWidget(createTestWidget(product: noDescProduct));
      await tester.pumpAndSettle();

      expect(
          find.text(
              'A comfortable and stylish classic sweatshirt perfect for everyday wear.'),
          findsOneWidget);
    });

    testWidgets('should add multiple items with different configurations',
        (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      // Scroll to make the ADD TO CART button visible
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      await tester.tap(find.text('ADD TO CART'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('CONTINUE SHOPPING'));
      await tester.pumpAndSettle();

      // Scroll back up to change color
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, 200));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Red'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Blue').last);
      await tester.pumpAndSettle();

      // Scroll down again
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      await tester.tap(find.text('ADD TO CART'));
      await tester.pumpAndSettle();

      expect(cart.itemCount, 2);
    });

    testWidgets('should display cart item with correct attributes',
        (tester) async {
      await tester.pumpWidget(createTestWidget(product: testProduct));
      await tester.pumpAndSettle();

      await tester.tap(find.text('S'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('L').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Red'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Blue').last);
      await tester.pumpAndSettle();

      // Scroll to make the buttons visible
      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -200));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -100));
      await tester.pumpAndSettle();

      await tester.tap(find.text('ADD TO CART'));
      await tester.pumpAndSettle();

      final cartItem = cart.items[0];
      expect(cartItem.title, 'Test Product');
      expect(cartItem.price, 25.99);
      expect(cartItem.quantity, 2);
      expect(cartItem.size, 'L');
      expect(cartItem.color, 'Blue');
    });

    testWidgets('should handle image load error', (tester) async {
      const invalidImageProduct = Product(
        id: 'test-7',
        name: 'Invalid Image',
        imageUrl: 'assets/nonexistent.png',
        price: 10.00,
        description: 'Product with invalid image',
        sizes: ['M'],
        colors: ['Black'],
      );

      await tester.pumpWidget(createTestWidget(product: invalidImageProduct));
      await tester.pumpAndSettle();

      // Find the larger image_not_supported icon (64 size) in the product image area
      final imageIcons = find.byIcon(Icons.image_not_supported);
      expect(imageIcons, findsWidgets);
      expect(find.text('Image unavailable'), findsOneWidget);
    });
  });
}
