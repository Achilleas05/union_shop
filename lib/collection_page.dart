import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  late List<Product> _allCollectionProducts;
  late List<Product> _filteredAndSortedProducts;

  int _currentPage = 1;
  final int _pageSize = 6;

  int get _totalPages => _filteredAndSortedProducts.isEmpty
      ? 1
      : (_filteredAndSortedProducts.length / _pageSize).ceil();

  @override
  void initState() {
    super.initState();
    // Base list for this collection
    _allCollectionProducts = List<Product>.from(widget.collectionProducts);
    _applyFilterAndSort();
  }

  void _applyFilterAndSort() {
    // Start from full collection
    List<Product> result = List<Product>.from(_allCollectionProducts);

    // FILTER
    switch (_selectedFilter) {
      case 'Clothing':
        result = result.where((p) => p.category == 'Clothing').toList();
        break;
      case 'Accessories':
        result = result.where((p) => p.category == 'Accessories').toList();
        break;
      case 'Sale items':
        result = result.where((p) => p.isOnSale || p.tag == 'Sale').toList();
        break;
      case 'New arrivals':
        result = result.where((p) => p.isNew).toList();
        break;
      case 'All products':
      default:
        break;
    }

    // SORT
    switch (_selectedSort) {
      case 'Price: Low to High':
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'A-Z':
        result.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case 'Featured':
      default:
        break;
    }

    setState(() {
      _filteredAndSortedProducts = result;
      _currentPage = 1; // reset to first page whenever criteria change
    });
  }

  void _onSortChanged(String? value) {
    if (value == null) return;
    _selectedSort = value;
    _applyFilterAndSort();
  }

  void _onFilterChanged(String? value) {
    if (value == null) return;
    _selectedFilter = value;
    _applyFilterAndSort();
  }

  List<Product> _currentPageItems() {
    if (_filteredAndSortedProducts.isEmpty) return const [];
    final startIndex = (_currentPage - 1) * _pageSize;
    final endIndex =
        (startIndex + _pageSize).clamp(0, _filteredAndSortedProducts.length);
    return _filteredAndSortedProducts.sublist(startIndex, endIndex);
  }

  void _goToPreviousPage() {
    if (_currentPage <= 1) return;
    setState(() {
      _currentPage--;
    });
  }

  void _goToNextPage() {
    if (_currentPage >= _totalPages) return;
    setState(() {
      _currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageItems = _currentPageItems();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(),
            if (widget.collectionTitle == 'Sale Items')
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'SALE',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Don’t miss out! Get yours before they’re all gone!",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "All prices shown are inclusive of the discount 🛒",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            if (widget.collectionTitle == 'Essential Range')
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Essential Range',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4d2963),
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Quality basics, everyday value.",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Over 20% off our Essential Range—stock up for the semester!",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            if (widget.collectionTitle == 'University Clothing')
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'University Clothing',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E8B57),
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Show your university pride.",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Browse our official campus apparel—perfect for every student.",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            if (widget.collectionTitle == 'Study Supplies')
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Study Supplies',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E90FF),
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Gear up for success.",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Find essential stationery and accessories for every student.",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            if (widget.collectionTitle == 'Gift Shop')
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Gift Shop',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF6347),
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Share a piece of Portsmouth.",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Souvenirs and gifts for every occasion—find something to make someone smile.",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            _buildHeader(),
            _buildFilterRow(),
            const SizedBox(height: 24),
            _buildProductGrid(pageItems),
            const SizedBox(height: 16),
            _buildPaginationControls(),
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
              '${_filteredAndSortedProducts.length} products in this collection',
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
            onChanged: _onSortChanged,
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
            onChanged: _onFilterChanged,
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

  Widget _buildProductGrid(List<Product> pageItems) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
          children: pageItems.map(_buildProductCard).toList(),
        ),
      );

  Widget _buildPaginationControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _currentPage > 1 ? _goToPreviousPage : null,
            icon: const Icon(Icons.chevron_left),
          ),
          Text('Page $_currentPage of $_totalPages'),
          IconButton(
            onPressed: _currentPage < _totalPages ? _goToNextPage : null,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) => GestureDetector(
        onTap: () {
          context.go('/product/${product.id}');
        },
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
