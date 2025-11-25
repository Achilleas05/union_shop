import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/models/product.dart';

class CollectionPage extends StatefulWidget {
  final String collectionTitle;
  final List<Product> collectionProducts;

  const CollectionPage({
    super.key,
    required this.collectionTitle,
    required this.collectionProducts,
  });

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
            Text(
              '${widget.collectionProducts.length} products in this collection',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );

  Widget _buildFilterRow() {
    const borderStyle =
        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));
    const dropdownPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 8);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _buildDropdown(
            value: _selectedSort,
            label: 'Sort by',
            items: const [
              'Featured',
              'Price: Low to High',
              'Price: High to Low',
              'A-Z'
            ],
            onChanged: (value) => setState(() => _selectedSort = value),
            borderStyle: borderStyle,
            contentPadding: dropdownPadding,
          ),
          const SizedBox(width: 12),
          _buildDropdown(
            value: _selectedFilter,
            label: 'Filter',
            items: const [
              'All products',
              'Clothing',
              'Accessories',
              'Sale items',
              'New arrivals'
            ],
            onChanged: (value) => setState(() => _selectedFilter = value),
            borderStyle: borderStyle,
            contentPadding: dropdownPadding,
          ),
        ],
      ),
    );
  }

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
          initialValue: value,
          decoration: InputDecoration(
            labelText: label,
            border: borderStyle,
            enabledBorder: borderStyle,
            focusedBorder: borderStyle,
            contentPadding: contentPadding,
          ),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      );

  Widget _buildProductGrid() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
          children: widget.collectionProducts.map(_buildProductCard).toList(),
        ),
      );

  Widget _buildProductCard(Product product) => GestureDetector(
        onTap: () {},
        child: Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child:
                          const Center(child: Icon(Icons.image_not_supported)),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '£${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: product.originalPrice != null
                            ? Colors.red
                            : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (product.originalPrice != null)
                      Text(
                        '£${product.originalPrice!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    if (product.tag != null)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: product.tag == 'Sale'
                              ? Colors.red
                              : Colors.orange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          product.tag!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
