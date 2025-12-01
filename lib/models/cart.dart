import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final String imageUrl;
  final double price;
  int quantity;
  final String? size;
  final String? color;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
    this.size,
    this.color,
  });

  double get totalPrice => price * quantity;

  CartItem copyWith({
    String? id,
    String? productId,
    String? title,
    String? imageUrl,
    double? price,
    int? quantity,
    String? size,
    String? color,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }
}

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  double get totalAmount {
    return _items.fold(0, (total, item) => total + item.totalPrice);
  }
}
