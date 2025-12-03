import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/order.dart';
import 'package:union_shop/models/cart.dart';

void main() {
  group('Order Model Tests', () {
    late List<CartItem> mockItems;
    late DateTime testDate;

    setUp(() {
      testDate = DateTime(2024, 1, 15, 10, 30);
      mockItems = [
        CartItem(
          id: 'item1',
          productId: 'p1',
          title: 'Test Product 1',
          quantity: 2,
          price: 10.0,
          imageUrl: 'http://example.com/image1.jpg',
        ),
        CartItem(
          id: 'item2',
          productId: 'p2',
          title: 'Test Product 2',
          quantity: 1,
          price: 25.0,
          imageUrl: 'http://example.com/image2.jpg',
        ),
      ];
    });

    test('should create an Order with all parameters', () {
      final order = Order(
        id: 'order123',
        items: mockItems,
        total: 45.0,
        dateOrdered: testDate,
        status: 'Pending',
      );

      expect(order.id, 'order123');
      expect(order.items, mockItems);
      expect(order.total, 45.0);
      expect(order.dateOrdered, testDate);
      expect(order.status, 'Pending');
    });

    test('should create an Order with default status', () {
      final order = Order(
        id: 'order456',
        items: mockItems,
        total: 45.0,
        dateOrdered: testDate,
      );

      expect(order.status, 'Completed');
    });

    test('should convert Order to JSON correctly', () {
      final order = Order(
        id: 'order789',
        items: mockItems,
        total: 45.0,
        dateOrdered: testDate,
        status: 'Shipped',
      );

      final json = order.toJson();

      expect(json['id'], 'order789');
      expect(json['items'], isA<List>());
      expect(json['items'].length, 2);
      expect(json['total'], 45.0);
      expect(json['dateOrdered'], testDate.toIso8601String());
      expect(json['status'], 'Shipped');
    });

    test('should create Order from JSON correctly', () {
      final json = {
        'id': 'order999',
        'items': [
          {
            'id': 'item1',
            'productId': 'p1',
            'title': 'Test Product 1',
            'quantity': 2,
            'price': 10.0,
            'imageUrl': 'http://example.com/image1.jpg',
          },
          {
            'id': 'item2',
            'productId': 'p2',
            'title': 'Test Product 2',
            'quantity': 1,
            'price': 25.0,
            'imageUrl': 'http://example.com/image2.jpg',
          },
        ],
        'total': 45.0,
        'dateOrdered': testDate.toIso8601String(),
        'status': 'Processing',
      };

      final order = Order.fromJson(json);

      expect(order.id, 'order999');
      expect(order.items.length, 2);
      expect(order.items[0].productId, 'p1');
      expect(order.items[1].productId, 'p2');
      expect(order.total, 45.0);
      expect(order.dateOrdered, testDate);
      expect(order.status, 'Processing');
    });

    test('should handle null total in fromJson with default value', () {
      final json = {
        'id': 'order111',
        'items': [],
        'dateOrdered': testDate.toIso8601String(),
      };

      final order = Order.fromJson(json);

      expect(order.total, 0.0);
      expect(order.status, 'Completed');
    });

    test('should handle null status in fromJson with default value', () {
      final json = {
        'id': 'order222',
        'items': [],
        'total': 100.0,
        'dateOrdered': testDate.toIso8601String(),
      };

      final order = Order.fromJson(json);

      expect(order.status, 'Completed');
    });

    test('should handle empty items list', () {
      final order = Order(
        id: 'order333',
        items: [],
        total: 0.0,
        dateOrdered: testDate,
      );

      expect(order.items, isEmpty);
      expect(order.toJson()['items'], isEmpty);
    });

    test('should correctly serialize and deserialize Order', () {
      final originalOrder = Order(
        id: 'order444',
        items: mockItems,
        total: 45.0,
        dateOrdered: testDate,
        status: 'Delivered',
      );

      final json = originalOrder.toJson();
      final deserializedOrder = Order.fromJson(json);

      expect(deserializedOrder.id, originalOrder.id);
      expect(deserializedOrder.items.length, originalOrder.items.length);
      expect(deserializedOrder.total, originalOrder.total);
      expect(deserializedOrder.dateOrdered, originalOrder.dateOrdered);
      expect(deserializedOrder.status, originalOrder.status);
    });

    test('should handle integer total value in fromJson', () {
      final json = {
        'id': 'order555',
        'items': [],
        'total': 50,
        'dateOrdered': testDate.toIso8601String(),
        'status': 'Completed',
      };

      final order = Order.fromJson(json);

      expect(order.total, 50.0);
    });
  });
}
