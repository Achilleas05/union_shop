import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/header.dart';
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
      case 'Sale items':
        result = result
            .where((p) => p.tag == 'Sale' || p.originalPrice != null)
            .toList();
        break;
      case 'New arrivals':
        // Filter by tag == 'New' since there's no isNew field
        result = result.where((p) => p.tag == 'New').toList();
        break;
      case 'Clothing':
      case 'Accessories':
      case 'Study Supplies':
      case 'Electronics':
      case 'Gift':
        // These filters don't work because Product has no category field
        // Keep all products for now
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(),
            if (widget.collectionTitle == 'Sale Items')
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 12.0 : 16.0,
                    horizontal: isMobile ? 16.0 : 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'SALE',
                      style: TextStyle(
                        fontSize: isMobile ? 28 : 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Don't miss out! Get yours before they're all gone!",
                      style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "All prices shown are inclusive of the discount 🛒",
                      style: TextStyle(
                          fontSize: isMobile ? 12 : 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            if (widget.collectionTitle == 'Essential Range')
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 12.0 : 16.0,
                    horizontal: isMobile ? 16.0 : 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Essential Range',
                      style: TextStyle(
                        fontSize: isMobile ? 28 : 34,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4d2963),
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Quality basics, everyday value.",
                      style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Over 20% off our Essential Range—stock up for the semester!",
                      style: TextStyle(
                          fontSize: isMobile ? 12 : 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            if (widget.collectionTitle == 'University Clothing')
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 12.0 : 16.0,
                    horizontal: isMobile ? 16.0 : 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'University Clothing',
                      style: TextStyle(
                        fontSize: isMobile ? 28 : 34,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E8B57),
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Show your university pride.",
                      style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Browse our official campus apparel—perfect for every student.",
                      style: TextStyle(
                          fontSize: isMobile ? 12 : 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            if (widget.collectionTitle == 'Study Supplies')
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 12.0 : 16.0,
                    horizontal: isMobile ? 16.0 : 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Study Supplies',
                      style: TextStyle(
                        fontSize: isMobile ? 28 : 34,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E90FF),
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Gear up for success.",
                      style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Find essential stationery and accessories for every student.",
                      style: TextStyle(
                          fontSize: isMobile ? 12 : 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            if (widget.collectionTitle == 'Tech Essentials')
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 12.0 : 16.0,
                    horizontal: isMobile ? 16.0 : 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Tech Essentials',
                      style: TextStyle(
                        fontSize: isMobile ? 28 : 34,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF8A2BE2),
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Power up your studies.",
                      style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Essential technology and accessories for modern learning.",
                      style: TextStyle(
                          fontSize: isMobile ? 12 : 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            if (widget.collectionTitle == 'Gift Shop')
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 12.0 : 16.0,
                    horizontal: isMobile ? 16.0 : 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Gift Shop',
                      style: TextStyle(
                        fontSize: isMobile ? 28 : 34,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFF6347),
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Share a piece of Portsmouth.",
                      style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Souvenirs and gifts for every occasion—find something to make someone smile.",
                      style: TextStyle(
                          fontSize: isMobile ? 12 : 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            if (widget.collectionTitle == 'Graduation')
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 12.0 : 16.0,
                    horizontal: isMobile ? 16.0 : 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Graduation',
                      style: TextStyle(
                        fontSize: isMobile ? 28 : 34,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFD700),
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Celebrate your achievement.",
                      style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Everything you need for your special graduation day and memories to cherish forever.",
                      style: TextStyle(
                          fontSize: isMobile ? 12 : 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
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

  Widget _buildHeader() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        children: [
          Text(
            widget.collectionTitle,
            style: TextStyle(
                fontSize: isMobile ? 22 : 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '${_filteredAndSortedProducts.length} products in this collection',
            style: TextStyle(fontSize: isMobile ? 14 : 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    const borderStyle =
        OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));
    final dropdownPadding =
        EdgeInsets.symmetric(horizontal: isMobile ? 6 : 10, vertical: 8);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 24),
      child: Row(
        children: [
          Expanded(
            child: _buildDropdown(
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
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildDropdown(
              value: _selectedFilter,
              label: 'Filter',
              items: const [
                'All products',
                'Clothing',
                'Accessories',
                'Study Supplies',
                'Electronics',
                'Gift',
                'Sale items',
                'New arrivals'
              ],
              onChanged: _onFilterChanged,
              borderStyle: borderStyle,
              contentPadding: dropdownPadding,
            ),
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
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isDense: true,
      isExpanded: true,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        border: borderStyle,
        enabledBorder: borderStyle,
        focusedBorder: borderStyle,
        contentPadding: contentPadding,
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildProductGrid(List<Product> pageItems) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: isMobile ? 2 : 3,
        crossAxisSpacing: isMobile ? 12 : 16,
        mainAxisSpacing: isMobile ? 12 : 16,
        childAspectRatio: isMobile ? 0.65 : 0.75,
        children: pageItems.map(_buildProductCard).toList(),
      ),
    );
  }

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
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
            ],
          ),
        ),
      );
}
