import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart.dart';

void main() {
  group('CartItem', () {
    test('creates CartItem with required fields', () {
      final cartItem = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
      );

      expect(cartItem.id, '1');
      expect(cartItem.productId, 'p1');
      expect(cartItem.title, 'Test Product');
      expect(cartItem.imageUrl, 'https://example.com/image.jpg');
      expect(cartItem.price, 10.0);
      expect(cartItem.quantity, 1);
      expect(cartItem.size, null);
      expect(cartItem.color, null);
    });

    test('calculates totalPrice correctly', () {
      final cartItem = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
        quantity: 3,
      );

      expect(cartItem.totalPrice, 30.0);
    });

    test('copyWith creates new instance with updated values', () {
      final cartItem = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
        quantity: 1,
      );

      final updated = cartItem.copyWith(quantity: 5, size: 'L');

      expect(updated.quantity, 5);
      expect(updated.size, 'L');
      expect(updated.id, '1');
      expect(updated.productId, 'p1');
    });
  });

  group('Cart', () {
    late Cart cart;

    setUp(() {
      cart = Cart();
    });

    test('initializes with empty items', () {
      expect(cart.items, isEmpty);
      expect(cart.itemCount, 0);
      expect(cart.totalAmount, 0);
    });

    test('addItem adds new item to cart', () {
      final item = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
      );

      cart.addItem(item);

      expect(cart.itemCount, 1);
      expect(cart.items.first.productId, 'p1');
    });

    test('addItem increments quantity for existing item', () {
      final item1 = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
        quantity: 2,
      );

      final item2 = CartItem(
        id: '2',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
        quantity: 3,
      );

      cart.addItem(item1);
      cart.addItem(item2);

      expect(cart.itemCount, 1);
      expect(cart.items.first.quantity, 5);
    });

    test('addItem treats items with different sizes as separate', () {
      final item1 = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
        size: 'S',
      );

      final item2 = CartItem(
        id: '2',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
        size: 'L',
      );

      cart.addItem(item1);
      cart.addItem(item2);

      expect(cart.itemCount, 2);
    });

    test('addItem treats items with different colors as separate', () {
      final item1 = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
        color: 'Red',
      );

      final item2 = CartItem(
        id: '2',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
        color: 'Blue',
      );

      cart.addItem(item1);
      cart.addItem(item2);

      expect(cart.itemCount, 2);
    });

    test('totalAmount calculates correctly', () {
      final item1 = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Product 1',
        imageUrl: 'https://example.com/image1.jpg',
        price: 10.0,
        quantity: 2,
      );

      final item2 = CartItem(
        id: '2',
        productId: 'p2',
        title: 'Product 2',
        imageUrl: 'https://example.com/image2.jpg',
        price: 15.0,
        quantity: 3,
      );

      cart.addItem(item1);
      cart.addItem(item2);

      expect(cart.totalAmount, 65.0); // (10*2) + (15*3)
    });

    test('removeItem removes specific item from cart', () {
      final item = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
        size: 'M',
        color: 'Red',
      );

      cart.addItem(item);
      cart.removeItem('p1', size: 'M', color: 'Red');

      expect(cart.itemCount, 0);
    });

    test('updateQuantity updates item quantity', () {
      final item = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
      );

      cart.addItem(item);
      cart.updateQuantity('p1', 5);

      expect(cart.items.first.quantity, 5);
    });

    test('updateQuantity removes item when quantity is 0', () {
      final item = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
      );

      cart.addItem(item);
      cart.updateQuantity('p1', 0);

      expect(cart.itemCount, 0);
    });

    test('incrementQuantity increases quantity by 1', () {
      final item = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
        quantity: 2,
      );

      cart.addItem(item);
      cart.incrementQuantity('p1');

      expect(cart.items.first.quantity, 3);
    });

    test('decrementQuantity decreases quantity by 1', () {
      final item = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
        quantity: 3,
      );

      cart.addItem(item);
      cart.decrementQuantity('p1');

      expect(cart.items.first.quantity, 2);
    });

    test('decrementQuantity removes item when quantity reaches 0', () {
      final item = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 10.0,
        quantity: 1,
      );

      cart.addItem(item);
      cart.decrementQuantity('p1');

      expect(cart.itemCount, 0);
    });

    test('clear removes all items from cart', () {
      final item1 = CartItem(
        id: '1',
        productId: 'p1',
        title: 'Product 1',
        imageUrl: 'https://example.com/image1.jpg',
        price: 10.0,
      );

      final item2 = CartItem(
        id: '2',
        productId: 'p2',
        title: 'Product 2',
        imageUrl: 'https://example.com/image2.jpg',
        price: 15.0,
      );

      cart.addItem(item1);
      cart.addItem(item2);
      cart.clear();

      expect(cart.itemCount, 0);
      expect(cart.totalAmount, 0);
    });

    test('items returns unmodifiable list', () {
      final items = cart.items;
      expect(
          () => items.add(CartItem(
                id: '1',
                productId: 'p1',
                title: 'Test',
                imageUrl: 'url',
                price: 10.0,
              )),
          throwsUnsupportedError);
    });
  });
}
