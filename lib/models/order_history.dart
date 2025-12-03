import 'package:flutter/foundation.dart';
import 'package:union_shop/models/order.dart';
import 'package:union_shop/models/cart.dart';

class OrderHistory with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  int get orderCount => _orders.length;

  void addOrder(Cart cart) {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List.from(cart.items),
      total: cart.totalAmount,
      dateOrdered: DateTime.now(),
    );

    _orders.insert(0, order); // Add to beginning for newest first
    notifyListeners();
  }

  void clearHistory() {
    _orders.clear();
    notifyListeners();
  }

  Order? getOrderById(String id) {
    try {
      return _orders.firstWhere((order) => order.id == id);
    } catch (e) {
      return null;
    }
  }
}
