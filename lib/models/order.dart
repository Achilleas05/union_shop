import 'package:union_shop/models/cart.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double total;
  final DateTime dateOrdered;
  final String status;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.dateOrdered,
    this.status = 'Completed',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'items': items.map((item) => item.toJson()).toList(),
        'total': total,
        'dateOrdered': dateOrdered.toIso8601String(),
        'status': status,
      };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        items: (json['items'] as List)
            .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
            .toList(),
        total: (json['total'] ?? 0).toDouble(),
        dateOrdered: DateTime.parse(json['dateOrdered']),
        status: json['status'] ?? 'Completed',
      );
}
