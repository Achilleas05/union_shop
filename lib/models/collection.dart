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
}
