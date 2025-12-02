import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/fixtures.dart';

class CustomHeader extends StatefulWidget {
  final VoidCallback? onHomePressed;
  final VoidCallback? onAboutPressed;
  final VoidCallback? onCartPressed;

  const CustomHeader({
    super.key,
    this.onHomePressed,
    this.onAboutPressed,
    this.onCartPressed,
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
    final isDesktop = screenWidth > 768;
    final isMobile = screenWidth < 600;

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
      child: Row(
        children: [
          _buildLogo(context, isMobile),
          SizedBox(width: isMobile ? 8 : 16),
          if (isDesktop && !_showSearch) _buildNavButtons(context),
          if (_showSearch) _buildSearchField(),
          if (!_showSearch && isMobile) const Spacer(),
          _buildRightIcons(context, isDesktop, isMobile),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context, bool isMobile) {
    return GestureDetector(
      onTap: widget.onHomePressed ?? () => context.go('/'),
      child: Image.network(
        'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
        height: isMobile ? 24 : 30,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.grey[300],
          width: isMobile ? 24 : 30,
          height: isMobile ? 24 : 30,
          child: const Center(
            child:
                Icon(Icons.image_not_supported, color: Colors.grey, size: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButtons(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _navButton('Home', () => context.go('/'), const Color(0xFF4d2963)),
          const SizedBox(width: 16),
          _navButton(
              'SALE!', () => context.go('/collections/sale-items'), Colors.red,
              bold: true),
          const SizedBox(width: 16),
          _navButton('PRINT SHACK', () => context.go('/print-shack'),
              const Color(0xFF4d2963)),
          _navButton(
              'About',
              widget.onAboutPressed ?? () => context.go('/about'),
              const Color(0xFF4d2963)),
        ],
      ),
    );
  }

  Widget _navButton(String text, VoidCallback onPressed, Color color,
      {bool bold = false}) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: bold ? FontWeight.bold : FontWeight.w600,
          letterSpacing: bold ? 1.2 : 0,
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Expanded(
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildRightIcons(BuildContext context, bool isDesktop, bool isMobile) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!_showSearch) _buildSearchIcon(),
        _buildIcon(Icons.person_outline, () => context.go('/login')),
        _buildCartIcon(context),
        if (!isDesktop) _buildMobileMenu(context),
      ],
    );
  }

  Widget _buildSearchIcon() {
    return IconButton(
      icon: const Icon(Icons.search, size: 18, color: Colors.grey),
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      onPressed: () {
        setState(() => _showSearch = true);
        _searchFocusNode.requestFocus();
      },
    );
  }

  Widget _buildIcon(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon, size: 18, color: Colors.grey),
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      onPressed: onPressed,
    );
  }

  Widget _buildCartIcon(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined,
              size: 18, color: Colors.grey),
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: widget.onCartPressed ?? () => context.go('/cart'),
        ),
        Consumer<Cart>(
          builder: (context, cart, _) {
            if (cart.itemCount == 0) return const SizedBox.shrink();
            return Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  '${cart.itemCount}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'home':
            context.go('/');
            break;
          case 'about':
            context.go('/about');
            break;
          case 'sale':
            context.go('/collections/sale-items');
            break;
          case 'print_shack':
            context.go('/print-shack');
            break;
        }
      },
      itemBuilder: (_) => const [
        PopupMenuItem(value: 'home', child: Text('Home')),
        PopupMenuItem(value: 'about', child: Text('About')),
        PopupMenuItem(value: 'sale', child: Text('SALE!')),
        PopupMenuItem(value: 'print_shack', child: Text('PRINT SHACK')),
      ],
      icon: const Icon(Icons.menu, size: 18, color: Colors.grey),
    );
  }
}
