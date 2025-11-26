import 'package:flutter/material.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/models/product.dart';

class ProductPage extends StatefulWidget {
  final Product? product;
  const ProductPage({super.key, this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product ?? _createDummyProduct();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(),
            _buildProductContent(product),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductContent(Product product) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 768;

          if (isDesktop) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductImage(product),
                const SizedBox(width: 40),
                Expanded(child: _buildProductDetails(product)),
              ],
            );
          } else {
            return Column(
              children: [
                _buildProductImage(product),
                const SizedBox(height: 20),
                _buildProductDetails(product),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildProductImage(Product product) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        product.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('Image unavailable',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductDetails(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        // Product price
        Text(
          '£${product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4d2963),
          ),
        ),

        const SizedBox(height: 24),

        // Product description
        const Text(
          'Description',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'This is a placeholder description for the product.',
          style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
        ),
      ],
    );
  }

  Product _createDummyProduct() {
    return const Product(
      id: 'classic-sweatshirt-1',
      name: 'Classic Sweatshirt',
      imageUrl: 'assets/portsmouth_hoodie.png',
      price: 29.99,
      originalPrice: 39.99,
      tag: 'Sale',
      description: '',
      sizes: [],
      colors: [],
    );
  }
}
