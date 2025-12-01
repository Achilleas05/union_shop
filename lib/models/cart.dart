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

  void addItem(CartItem newItem) {
    // Check if item already exists
    final existingIndex = _items.indexWhere(
      (item) =>
          item.productId == newItem.productId &&
          item.size == newItem.size &&
          item.color == newItem.color,
    );

    if (existingIndex >= 0) {
      // Update quantity if item exists
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + newItem.quantity,
      );
    } else {
      // Add new item
      _items.add(newItem);
    }
    notifyListeners();
  }

  void removeItem(String productId, {String? size, String? color}) {
    _items.removeWhere(
      (item) =>
          item.productId == productId &&
          item.size == size &&
          item.color == color,
    );
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity,
      {String? size, String? color}) {
    if (quantity <= 0) {
      removeItem(productId, size: size, color: color);
      return;
    }

    final index = _items.indexWhere(
      (item) =>
          item.productId == productId &&
          item.size == size &&
          item.color == color,
    );

    if (index >= 0) {
      _items[index] = _items[index].copyWith(quantity: quantity);
      notifyListeners();
    }
  }

  void incrementQuantity(String productId, {String? size, String? color}) {
    final index = _items.indexWhere(
      (item) =>
          item.productId == productId &&
          item.size == size &&
          item.color == color,
    );

    if (index >= 0) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
      notifyListeners();
    }
  }

  void decrementQuantity(String productId, {String? size, String? color}) {
    final index = _items.indexWhere(
      (item) =>
          item.productId == productId &&
          item.size == size &&
          item.color == color,
    );

    if (index >= 0) {
      final newQuantity = _items[index].quantity - 1;
      if (newQuantity <= 0) {
        removeItem(productId, size: size, color: color);
      } else {
        _items[index] = _items[index].copyWith(quantity: newQuantity);
        notifyListeners();
      }
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
