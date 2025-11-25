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
            const Text(
              'Curated picks for the season. Explore our favourite hoodies, tees and accessories.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
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
            floatingLabelStyle: const TextStyle(color: Colors.grey),
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

  Widget _buildProductCard(Product product) => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductImage(product),
                _buildProductInfo(product),
              ],
            ),
          ),
        ),
      );

  Widget _buildProductImage(Product product) => Expanded(
        flex: 3,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                image: DecorationImage(
                  image: AssetImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (product.tag != null) _buildProductTag(product.tag!),
          ],
        ),
      );

  Widget _buildProductTag(String tag) => Positioned(
        top: 8,
        left: 8,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: tag == 'Sale' ? Colors.red : Colors.orange,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  Widget _buildProductInfo(Product product) => Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product.name,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              _buildPriceRow(product),
            ],
          ),
        ),
      );

  Widget _buildPriceRow(Product product) => Row(
        children: [
          if (product.originalPrice != null) ...[
            Text(
              '£${product.originalPrice!.toStringAsFixed(2)}',
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            '£${product.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: product.originalPrice != null ? Colors.red : Colors.black,
            ),
          ),
        ],
      );
}
