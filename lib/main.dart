import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/header.dart';
import 'package:union_shop/footer.dart'; // Add this import
import 'package:union_shop/collection_page.dart';
import 'package:union_shop/models/fixtures.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/product',
          builder: (context, state) => const ProductPage(),
        ),
        GoRoute(
          path: '/product/:productId',
          builder: (context, state) {
            final productId = state.pathParameters['productId'];
            final product = products.firstWhere(
              (p) => p.id == productId,
              orElse: () => products.first,
            );
            return ProductPage(product: product);
          },
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const AboutPage(),
        ),
        GoRoute(
          path: '/collections',
          builder: (context, state) => const CollectionsPage(),
        ),
        GoRoute(
          path: '/collections/:collectionId',
          builder: (context, state) {
            final id = state.pathParameters['collectionId']!;
            final collection = collections.firstWhere(
              (c) => c.id == id,
              orElse: () => collections.first,
            );

            return CollectionPage(
              collectionTitle: collection.name,
              collectionProducts: collection.products,
            );
          },
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToHome(BuildContext context) => context.go('/');
  void navigateToProduct(BuildContext context) => context.go('/product');
  void navigateToAbout(BuildContext context) => context.go('/about');
  void navigateToCollections(BuildContext context) =>
      context.go('/collections');

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(),

            // Hero Section
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background image
                  Positioned.fill(
                    child: Container(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  // Content overlay
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Essential Range - Over 20% OFF!',
                          style: TextStyle(
                            fontSize: isMobile ? 36 : 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                            letterSpacing: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Over 20% off our Essential Range. Come and grab yours while stock lasts!",
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.5,
                            letterSpacing: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () => navigateToCollections(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text(
                            'BROWSE COLLECTION',
                            style: TextStyle(fontSize: 14, letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Products Section
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    const Text(
                      'FEATURED PRODUCTS',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 48),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 48,
                      children: const [
                        ProductCard(
                          title: 'Portsmouth City Magnet',
                          price: '£3.50',
                          imageUrl: 'assets/portsmouth_magnet.png',
                          productId: 'magnet-1',
                        ),
                        ProductCard(
                          title: 'University Hoodie Navy',
                          price: '£29.99',
                          imageUrl: 'assets/portsmouth_hoodie.png',
                          productId: 'hoodie-1',
                        ),
                        ProductCard(
                          title: 'Pom Pom Beanie',
                          price: '£12.00',
                          imageUrl: 'assets/portsmouth_beanie.png',
                          productId: 'beanie-1',
                        ),
                        ProductCard(
                          title: 'UPSU Tote Bag',
                          price: '£6.00',
                          imageUrl: 'assets/portsmouth_bag.png',
                          productId: 'bag-1',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Footer(),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final String productId;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/product/$productId'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
