import 'package:flutter/material.dart';
import 'product.dart';

class Collection {
  final String id;
  final String name;
  final Color color;
  final IconData icon;
  final List<Product> products;

  const Collection({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.products,
  });

  // Add methods for coverage
  int get productCount => products.length;

  bool get isEmpty => products.isEmpty;

  bool get isNotEmpty => products.isNotEmpty;

  Product? getProductById(String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  Collection copyWith({
    String? id,
    String? name,
    Color? color,
    IconData? icon,
    List<Product>? products,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      products: products ?? this.products,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Collection &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          color == other.color &&
          icon == other.icon &&
          _listEquals(products, other.products);

  bool _listEquals(List<Product> a, List<Product> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      color.hashCode ^
      icon.hashCode ^
      products.hashCode;

  @override
  String toString() {
    return 'Collection{id: $id, name: $name, products: ${products.length}}';
  }
}
