import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/widgets/search_overlay.dart';

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

  void _closeSearch() {
    setState(() => _showSearch = false);
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Left side - Logo (only show when not searching on mobile)
          if (!(_showSearch && isMobile))
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLogo(context, isMobile),
                ],
              ),
            ),

          // Center - Nav buttons or Search
          if (isDesktop && !_showSearch)
            Align(
              alignment: Alignment.center,
              child: _buildNavButtons(context),
            ),

          if (_showSearch)
            Align(
              alignment: Alignment.center,
              child: Container(
                width: isMobile ? double.infinity : null,
                constraints: isMobile
                    ? const BoxConstraints(maxWidth: double.infinity)
                    : const BoxConstraints(maxWidth: 400),
                padding: isMobile ? const EdgeInsets.only(right: 48) : null,
                child: SearchOverlay(onClose: _closeSearch),
              ),
            ),

          // Right side - Icons (only show when not searching on mobile)
          if (!(_showSearch && isMobile))
            Align(
              alignment: Alignment.centerRight,
              child: _buildRightIcons(context, isDesktop, isMobile),
            ),
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _navButton('Home', () => context.go('/'), const Color(0xFF4d2963)),
        const SizedBox(width: 16),
        _navButton(
            'SALE!', () => context.go('/collections/sale-items'), Colors.red,
            bold: true),
        const SizedBox(width: 16),
        _navButton('PRINT SHACK', () => context.go('/print-shack'),
            const Color(0xFF4d2963)),
        _navButton('About', widget.onAboutPressed ?? () => context.go('/about'),
            const Color(0xFF4d2963)),
      ],
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

  Widget _buildRightIcons(BuildContext context, bool isDesktop, bool isMobile) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!_showSearch) _buildSearchIcon(),
        if (!_showSearch)
          _buildIcon(Icons.person_outline, () => context.go('/login')),
        if (!_showSearch) _buildCartIcon(context),
        if (!isDesktop && !_showSearch) _buildMobileMenu(context),

        // Add close button when searching on mobile
        if (_showSearch && isMobile)
          IconButton(
            icon: const Icon(Icons.close, size: 18, color: Colors.grey),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            onPressed: _closeSearch,
          ),
      ],
    );
  }

  Widget _buildSearchIcon() {
    return IconButton(
      icon: const Icon(Icons.search, size: 18, color: Colors.grey),
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      onPressed: () => setState(() => _showSearch = true),
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
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return InkWell(
          onTap: widget.onCartPressed ?? () => context.go('/cart'),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart, size: 18, color: Colors.grey),
                if (cart.itemCount > 0)
                  Positioned(
                    right: -8,
                    top: -8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Text(
                        '${cart.itemCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
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
