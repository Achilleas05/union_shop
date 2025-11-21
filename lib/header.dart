import 'package:flutter/material.dart';

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
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  @override
  Widget build(BuildContext context) {
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
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed:
                              onHomePressed ?? () => navigateToHome(context),
                          child: const Text('Home'),
                        ),
                      ],
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
