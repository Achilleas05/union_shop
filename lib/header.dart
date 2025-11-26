import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop =
        screenWidth > 768; // A common breakpoint for tablets/desktops

    return Container(
      height: 140,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              height: 30,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              width: 30,
                              height: 30,
                              child: const Center(
                                child: Icon(Icons.image_not_supported,
                                    color: Colors.grey),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(width: 16),
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
                            icon: const Icon(
                              Icons.search,
                              size: 18,
                              color: Colors.grey,
                            ),
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                            onPressed: onSearchPressed,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.person_outline,
                              size: 18,
                              color: Colors.grey,
                            ),
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                            onPressed: onProfilePressed,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.shopping_bag_outlined,
                              size: 18,
                              color: Colors.grey,
                            ),
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                            onPressed: onCartPressed,
                          ),
                          // On mobile, show a popup menu. On desktop, show a simple icon.
                          if (!isDesktop) // Only show menu button on mobile
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'home') {
                                  navigateToHome(context);
                                } else if (value == 'about') {
                                  navigateToAbout(context);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                    value: 'home', child: Text('Home')),
                                const PopupMenuItem(
                                    value: 'about', child: Text('About')),
                              ],
                              icon: const Icon(
                                Icons.menu,
                                size: 18,
                                color: Colors.grey,
                              ),
                              padding: const EdgeInsets.all(8),
                            ),
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
