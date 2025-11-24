import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/header.dart';

class CollectionPage extends StatefulWidget {
  final String collectionTitle;
  const CollectionPage({super.key, required this.collectionTitle});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomHeader(),
            SizedBox(height: 40),
            Footer(),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double? originalPrice;
  final String? tag;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    this.tag,
  });
}

const List<Product> products = [
  Product(
    id: 'hoodie-1',
    name: 'Union Autumn Hoodie',
    imageUrl: 'assets/portsmouth_hoodie.png',
    price: 34.99,
    originalPrice: 44.99,
    tag: 'Sale',
  ),
  Product(
    id: 'tshirt-1',
    name: 'Autumn Leaves T-Shirt',
    imageUrl: 'assets/portsmouth_hoodie.png',
    price: 19.99,
  ),
  Product(
    id: 'beanie-1',
    name: 'Wool Beanie',
    imageUrl: 'assets/portsmouth_hoodie.png',
    price: 12.99,
    tag: 'New',
  ),
  Product(
    id: 'scarf-1',
    name: 'Knit Scarf',
    imageUrl: 'assets/portsmouth_hoodie.png',
    price: 24.99,
    originalPrice: 29.99,
    tag: 'Sale',
  ),
  Product(
    id: 'mug-1',
    name: 'Autumn Mug',
    imageUrl: 'assets/portsmouth_hoodie.png',
    price: 8.99,
  ),
  Product(
    id: 'socks-1',
    name: 'Wool Socks',
    imageUrl: 'assets/portsmouth_hoodie.png',
    price: 6.99,
    tag: 'New',
  ),
];
