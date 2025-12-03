import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart.dart';

void main() {
  group('Cart Tests', () {
    late Cart cart;

    setUp(() {
      cart = Cart();
    });

    test('Cart starts empty', () {
      expect(cart.items.isEmpty, true);
      expect(cart.itemCount, 0);
      expect(cart.totalAmount, 0.0);
    });

    test('Add item to cart', () {
      final item = CartItem(
        id: '1',
        productId: 'prod1',
        title: 'Test Product',
        imageUrl: 'test.png',
        price: 10.0,
        quantity: 1,
      );

      cart.addItem(item);

      expect(cart.itemCount, 1);
      expect(cart.totalAmount, 10.0);
    });

    test('Add multiple items to cart', () {
      final item1 = CartItem(
        id: '1',
        productId: 'prod1',
        title: 'Product 1',
        imageUrl: 'test1.png',
        price: 10.0,
        quantity: 1,
      );

      final item2 = CartItem(
        id: '2',
        productId: 'prod2',
        title: 'Product 2',
        imageUrl: 'test2.png',
        price: 20.0,
        quantity: 1,
      );

      cart.addItem(item1);
      cart.addItem(item2);

      expect(cart.itemCount, 2);
      expect(cart.totalAmount, 30.0);
    });

    test('Remove item from cart', () {
      final item = CartItem(
        id: '1',
        productId: 'prod1',
        title: 'Test Product',
        imageUrl: 'test.png',
        price: 10.0,
        quantity: 1,
      );

      cart.addItem(item);
      cart.removeItem('prod1');

      expect(cart.itemCount, 0);
      expect(cart.totalAmount, 0.0);
    });

    test('Clear cart', () {
      final item1 = CartItem(
        id: '1',
        productId: 'prod1',
        title: 'Product 1',
        imageUrl: 'test1.png',
        price: 10.0,
        quantity: 1,
      );

      final item2 = CartItem(
        id: '2',
        productId: 'prod2',
        title: 'Product 2',
        imageUrl: 'test2.png',
        price: 20.0,
        quantity: 1,
      );

      cart.addItem(item1);
      cart.addItem(item2);
      cart.clear();

      expect(cart.itemCount, 0);
      expect(cart.totalAmount, 0.0);
    });

    test('Increment quantity', () {
      final item = CartItem(
        id: '1',
        productId: 'prod1',
        title: 'Test Product',
        imageUrl: 'test.png',
        price: 10.0,
        quantity: 1,
      );

      cart.addItem(item);
      cart.incrementQuantity('prod1');

      expect(cart.items.first.quantity, 2);
      expect(cart.totalAmount, 20.0);
    });

    test('Decrement quantity', () {
      final item = CartItem(
        id: '1',
        productId: 'prod1',
        title: 'Test Product',
        imageUrl: 'test.png',
        price: 10.0,
        quantity: 2,
      );

      cart.addItem(item);
      cart.decrementQuantity('prod1');

      expect(cart.items.first.quantity, 1);
      expect(cart.totalAmount, 10.0);
    });
  });
}
