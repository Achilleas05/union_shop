import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/fixtures.dart';

class CustomHeader extends StatefulWidget {
  final VoidCallback? onHomePressed;
  final VoidCallback? onAboutPressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onProfilePressed;
  final VoidCallback? onCartPressed;
  final VoidCallback? onMenuPressed;

  const CustomHeader({
    super.key,
    this.onHomePressed,
    this.onAboutPressed,
    this.onSearchPressed,
    this.onProfilePressed,
    this.onCartPressed,
    this.onMenuPressed,
  });

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  bool _showSearch = false;
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  List<Product> _searchResults = [];
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showResultsOverlay() {
    _removeOverlay();
    if (_searchResults.isEmpty) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 140,
        left: 0,
        right: 0,
        child: Material(
          elevation: 8,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 300),
            color: Colors.white,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final product = _searchResults[index];
                return ListTile(
                  leading: _buildProductImage(product.imageUrl),
                  title: Text(
                    product.title ?? product.name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    product.price.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  onTap: () => _navigateToProduct(context, product.id),
                );
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildProductImage(String imageUrl) {
    return Image.asset(
      imageUrl,
      width: 40,
      height: 40,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        width: 40,
        height: 40,
        color: Colors.grey[200],
        child: const Icon(Icons.image_not_supported),
      ),
    );
  }

  void _navigateToProduct(BuildContext context, String productId) {
    _removeOverlay();
    setState(() {
      _showSearch = false;
      _searchController.clear();
      _searchResults = [];
    });
    context.go('/product/$productId');
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      _removeOverlay();
      return;
    }

    final results = products.where((product) {
      final title = (product.title ?? '').toLowerCase();
      final description = product.description.toLowerCase();
      final searchQuery = query.toLowerCase();
      return title.contains(searchQuery) || description.contains(searchQuery);
    }).toList();

    setState(() => _searchResults = results);
    _showResultsOverlay();
  }

  void _closeSearch() {
    setState(() {
      _showSearch = false;
      _searchController.clear();
      _searchResults = [];
    });
    _removeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 768;
    final bool isMobile = screenWidth < 600;

    return Container(
      height: isDesktop ? 140 : 120,
      color: Colors.white,
      child: Column(
        children: [
          _buildBanner(isMobile),
          Expanded(child: _buildMainContent(context, isDesktop, isMobile)),
        ],
      ),
    );
  }

  Widget _buildBanner(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 8 : 12,
        horizontal: isMobile ? 8 : 16,
      ),
      color: const Color(0xFF4d2963),
      child: Text(
        'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: isMobile ? 12 : 16,
          fontWeight: FontWeight.bold,
          letterSpacing: isMobile ? 0.5 : 1.1,
        ),
      ),
    );
  }

  Widget _buildMainContent(
      BuildContext context, bool isDesktop, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: widget.onHomePressed ?? () => context.go('/'),
                  child: Image.network(
                      'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                      height: isMobile ? 24 : 30,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      width: isMobile ? 24 : 30,
                      height: isMobile ? 24 : 30,
                      child: const Center(
                        child: Icon(Icons.image_not_supported,
                            color: Colors.grey, size: 16),
                      ),
                    );
                  }),
                ),
                SizedBox(width: isMobile ? 8 : 16),
              ],
            ),
          ),
          // Only show centered navigation on wider screens
          if (isDesktop && !_showSearch)
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: widget.onHomePressed ?? () => context.go('/'),
                    child: const Text(
                      'Home',
                      style: TextStyle(
                        color: Color(0xFF4d2963),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () => context.go('/collections/sale-items'),
                    child: const Text(
                      'SALE!',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () => context.go('/print-shack'),
                    child: const Text(
                      'PRINT SHACK',
                      style: TextStyle(
                        color: Color(0xFF4d2963),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed:
                        widget.onAboutPressed ?? () => context.go('/about'),
                    child: const Text(
                      'About',
                      style: TextStyle(
                        color: Color(0xFF4d2963),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (_showSearch)
            Align(
              alignment: Alignment.center,
              child: Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onChanged: _performSearch,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search, size: 18),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: _closeSearch,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                    ),
                  ),
                ),
              ),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_showSearch)
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        size: isMobile ? 20 : 18,
                        color: Colors.grey,
                      ),
                      padding: EdgeInsets.all(isMobile ? 4 : 8),
                      constraints: BoxConstraints(
                        minWidth: isMobile ? 28 : 32,
                        minHeight: isMobile ? 28 : 32,
                      ),
                      onPressed: () {
                        setState(() => _showSearch = true);
                        _searchFocusNode.requestFocus();
                      },
                    ),
                  IconButton(
                    icon: Icon(
                      Icons.person_outline,
                      size: isMobile ? 20 : 18,
                      color: Colors.grey,
                    ),
                    padding: EdgeInsets.all(isMobile ? 4 : 8),
                    constraints: BoxConstraints(
                      minWidth: isMobile ? 28 : 32,
                      minHeight: isMobile ? 28 : 32,
                    ),
                    onPressed: () => context.go('/login'),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          size: isMobile ? 20 : 18,
                          color: Colors.grey,
                        ),
                        padding: EdgeInsets.all(isMobile ? 4 : 8),
                        constraints: BoxConstraints(
                          minWidth: isMobile ? 28 : 32,
                          minHeight: isMobile ? 28 : 32,
                        ),
                        onPressed:
                            widget.onCartPressed ?? () => context.go('/cart'),
                      ),
                      Consumer<Cart>(
                        builder: (context, cart, child) {
                          if (cart.itemCount == 0) {
                            return const SizedBox.shrink();
                          }
                          return Positioned(
                            right: isMobile ? 4 : 8,
                            top: isMobile ? 4 : 8,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child: Text(
                                cart.itemCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  // On mobile, show a popup menu. On desktop, show a simple icon.
                  if (!isDesktop &&
                      !_showSearch) // Only show menu button on mobile
                    PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'home') {
                          context.go('/');
                        } else if (value == 'about') {
                          context.go('/about');
                        } else if (value == 'sale') {
                          context.go('/collections/sale-items');
                        } else if (value == 'print_shack') {
                          context.go('/print-shack');
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'home', child: Text('Home')),
                        const PopupMenuItem(
                            value: 'about', child: Text('About')),
                        const PopupMenuItem(
                            value: 'sale', child: Text('SALE!')),
                        const PopupMenuItem(
                            value: 'print_shack', child: Text('PRINT SHACK')),
                      ],
                      icon: Icon(
                        Icons.menu,
                        size: isMobile ? 20 : 18,
                        color: Colors.grey,
                      ),
                      padding: EdgeInsets.all(isMobile ? 4 : 8),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
