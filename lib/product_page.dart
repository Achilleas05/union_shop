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
  String _selectedSize = 'M';
  String _selectedColor = 'Black';
  int _quantity = 1;

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
                _buildProductImage(product, 500),
                const SizedBox(width: 40),
                Expanded(child: _buildProductDetails(product)),
              ],
            );
          } else {
            return Column(
              children: [
                _buildProductImage(product, 300),
                const SizedBox(height: 20),
                _buildProductDetails(product),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildProductImage(Product product, double height) {
    return Expanded(
      flex: 2,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
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
                    Icon(Icons.image_not_supported,
                        size: 64, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Image unavailable',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductDetails(Product product) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildPriceSection(product),
          const SizedBox(height: 20),
          _buildOptionsSection(),
          const SizedBox(height: 30),
          _buildActionButtons(),
          const SizedBox(height: 30),
          _buildDescriptionSection(product),
        ],
      ),
    );
  }

  Widget _buildPriceSection(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.originalPrice != null) ...[
          Text(
            '£${product.originalPrice!.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(height: 4),
        ],
        Text(
          '£${product.price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4d2963),
          ),
        ),
        if (product.tag != null) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: product.tag == 'Sale' ? Colors.red : Colors.orange,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              product.tag!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildOptionsSection() {
    return Column(
      children: [
        _buildDropdown('Size', _selectedSize, ['S', 'M', 'L', 'XL'], (value) {
          setState(() => _selectedSize = value!);
        }),
        const SizedBox(height: 20),
        _buildDropdown(
            'Color', _selectedColor, ['Black', 'Navy', 'Grey', 'White'],
            (value) {
          setState(() => _selectedColor = value!);
        }),
        const SizedBox(height: 20),
        _buildQuantitySelector(),
      ],
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: items.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quantity:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => setState(() {
                    if (_quantity > 1) _quantity--;
                  }),
                ),
                Container(
                    width: 40,
                    alignment: Alignment.center,
                    child: Text(_quantity.toString())),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => _quantity++),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4d2963),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: const Text('ADD TO CART',
                style: TextStyle(fontSize: 14, letterSpacing: 1)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: const Text('BUY NOW',
                style: TextStyle(fontSize: 14, letterSpacing: 1)),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          product.description.isNotEmpty
              ? product.description
              : 'A comfortable and stylish classic sweatshirt perfect for everyday wear.',
          style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.grey),
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
