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
  String? _selectedFilter = 'All products';
  String? _selectedSort = 'Featured';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(),
            _buildHeader(),
            _buildFilterRow(),
            const SizedBox(height: 24),
            _buildProductGrid(),
            const SizedBox(height: 40),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              widget.collectionTitle,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Curated picks for the season. Explore our favourite hoodies, tees and accessories.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );

  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(child: Container()), // Placeholder for sort dropdown
          const SizedBox(width: 12),
          Expanded(child: Container()), // Placeholder for filter dropdown
        ],
      ),
    );
  }

  static const borderStyle =
      OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));
  static const dropdownPadding =
      EdgeInsets.symmetric(horizontal: 12, vertical: 8);

  Widget _buildDropdown({
    required String? value,
    required String label,
    required List<String> items,
    required Function(String?) onChanged,
    required InputBorder borderStyle,
    required EdgeInsetsGeometry contentPadding,
  }) =>
      Expanded(
        child: DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            labelText: label,
            border: borderStyle,
            enabledBorder: borderStyle,
            focusedBorder: borderStyle,
            contentPadding: contentPadding,
            floatingLabelStyle: const TextStyle(color: Colors.grey),
          ),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      );

  Widget _buildProductGrid() {
    return Container();
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
