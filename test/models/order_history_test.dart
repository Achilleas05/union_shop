// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/order_history.dart';
import 'package:union_shop/models/cart.dart';

void main() {
  group('OrderHistory', () {
    late OrderHistory orderHistory;
    late Cart mockCart;

    setUp(() {
      orderHistory = OrderHistory();
      // Create a mock cart with sample items
      mockCart = Cart();
      // Assuming Cart has methods to add items; adjust if needed
      // For simplicity, we'll assume Cart can be initialized with items
      // If Cart is complex, use a mock library like mockito
    });

    test('initial state', () {
      expect(orderHistory.orders, isEmpty);
      expect(orderHistory.orderCount, 0);
    });

    test('addOrder adds order to beginning and notifies', () {
      bool notified = false;
      orderHistory.addListener(() => notified = true);

      orderHistory.addOrder(mockCart);

      expect(orderHistory.orderCount, 1);
      expect(orderHistory.orders.first.id, isNotNull);
      expect(orderHistory.orders.first.items, equals(mockCart.items));
      expect(orderHistory.orders.first.total, equals(mockCart.totalAmount));
      expect(notified, true);
    });

    test('addOrder with multiple orders', () {
      orderHistory.addOrder(mockCart);
      orderHistory.addOrder(mockCart); // Add another

      expect(orderHistory.orderCount, 2);
      expect(
          orderHistory.orders[0].dateOrdered
              .isAfter(orderHistory.orders[1].dateOrdered),
          true); // Newest first
    });

    test('clearHistory clears all orders and notifies', () {
      orderHistory.addOrder(mockCart);
      bool notified = false;
      orderHistory.addListener(() => notified = true);

      orderHistory.clearHistory();

      expect(orderHistory.orders, isEmpty);
      expect(orderHistory.orderCount, 0);
      expect(notified, true);
    });

    test('getOrderById returns correct order', () {
      orderHistory.addOrder(mockCart);
      final orderId = orderHistory.orders.first.id;

      final retrieved = orderHistory.getOrderById(orderId);

      expect(retrieved, isNotNull);
      expect(retrieved!.id, orderId);
    });

    test('getOrderById returns null for non-existing id', () {
      final retrieved = orderHistory.getOrderById('non-existing');

      expect(retrieved, isNull);
    });
  });
}
