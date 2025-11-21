import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/header.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const CustomHeader(),

            // Page Title - Centered
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: const Text(
                'Collections',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // Collections Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 72),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.0,
                children: [],
              ),
            ),
            const SizedBox(height: 60),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class Collection {
  final String name;
  final Color color;
  final IconData icon;

  const Collection({
    required this.name,
    required this.color,
    required this.icon,
  });
}

// Hardcoded collections data with colors and icons
final List<Collection> collections = [
  const Collection(
    name: 'Essential Range',
    color: Color(0xFF4d2963),
    icon: Icons.star_border,
  ),
  const Collection(
    name: 'University Clothing',
    color: Color(0xFF2E8B57),
    icon: Icons.flag,
  ),
  const Collection(
    name: 'Study Supplies',
    color: Color(0xFF1E90FF),
    icon: Icons.school,
  ),
  const Collection(
    name: 'Gift Shop',
    color: Color(0xFFFF6347),
    icon: Icons.card_giftcard,
  ),
  const Collection(
    name: 'Limited Edition',
    color: Color(0xFFFFD700),
    icon: Icons.lock_clock,
  ),
  const Collection(
    name: 'Sale Items',
    color: Color(0xFFDC143C),
    icon: Icons.local_offer,
  ),
];
