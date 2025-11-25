import 'package:flutter/material.dart';
import 'product.dart';
import 'collection.dart';

const List<Product> products = [
  Product(
    id: 'hoodie-1',
    name: 'University Hoodie Navy',
    imageUrl: 'assets/portsmouth_hoodie.png',
    price: 34.99,
    originalPrice: 44.99,
    tag: 'Sale',
  ),
  Product(
    id: 'beanie-1',
    name: 'Pom Pom Beanie',
    imageUrl: 'assets/portsmouth_beanie.png',
    price: 12.99,
    tag: 'New',
  ),
  Product(
    id: 'bag-1',
    name: 'UPSU Tote Bag',
    imageUrl: 'assets/portsmouth_bag.png',
    price: 12.99,
  ),
  Product(
    id: 'magnet-1',
    name: 'Portsmouth City Magnet',
    imageUrl: 'assets/portsmouth_magnet.png',
    price: 3.50,
  ),
];

final List<Collection> collections = [
  Collection(
    id: 'essential-range',
    name: 'Essential Range',
    color: const Color(0xFF4d2963),
    icon: Icons.star_border,
    products: [products[0], products[1], products[2]], // Hoodie, Beanie, Bag
  ),
  Collection(
    id: 'university-clothing',
    name: 'University Clothing',
    color: const Color(0xFF2E8B57),
    icon: Icons.flag,
    products: [products[0], products[1]], // Hoodie, Beanie
  ),
  Collection(
    id: 'study-supplies',
    name: 'Study Supplies',
    color: const Color(0xFF1E90FF),
    icon: Icons.school,
    products: [products[3]], // Magnet
  ),
  Collection(
    id: 'gift-shop',
    name: 'Gift Shop',
    color: const Color(0xFFFF6347),
    icon: Icons.card_giftcard,
    products: [products[2], products[3]], // Bag, Magnet
  ),
  Collection(
    id: 'sale-items',
    name: 'Sale Items',
    color: const Color(0xFFDC143C),
    icon: Icons.local_offer,
    products: [products[0]], // Hoodie on sale
  ),
];
