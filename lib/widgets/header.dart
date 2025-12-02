import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';

class CustomHeader extends StatelessWidget {
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

  void navigateToHome(BuildContext context) {
    context.go('/'); // CHANGE TO context.go
  }

  void navigateToAbout(BuildContext context) {
    context.go('/about'); // CHANGE TO context.go
  }

  void navigateToCart(BuildContext context) {
    context.go('/cart');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop =
        screenWidth > 768; // A common breakpoint for tablets/desktops
    final bool isMobile = screenWidth < 600;

    return Container(
      height: isDesktop ? 140 : 120,
      color: Colors.white,
      child: Column(
        children: [
          Container(
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
          ),
          Expanded(
            child: Container(
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
                          onTap: onHomePressed ?? () => navigateToHome(context),
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
                  if (isDesktop)
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed:
                                onHomePressed ?? () => navigateToHome(context),
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
                            onPressed: () =>
                                context.go('/collections/sale-items'),
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
                            onPressed: onAboutPressed ??
                                () => navigateToAbout(context),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                            onPressed: onSearchPressed,
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
                                onPressed: onCartPressed ??
                                    () => navigateToCart(context),
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
                          if (!isDesktop) // Only show menu button on mobile
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'home') {
                                  navigateToHome(context);
                                } else if (value == 'about') {
                                  navigateToAbout(context);
                                } else if (value == 'sale') {
                                  context.go('/collections/sale-items');
                                } else if (value == 'print_shack') {
                                  context.go('/print-shack');
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                    value: 'home', child: Text('Home')),
                                const PopupMenuItem(
                                    value: 'about', child: Text('About')),
                                const PopupMenuItem(
                                    value: 'sale', child: Text('SALE!')),
                                const PopupMenuItem(
                                    value: 'print_shack',
                                    child: Text('PRINT SHACK')),
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
            ),
          )
        ],
      ),
    );
  }
}
