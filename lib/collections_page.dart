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
                children: collections.map((Collection col) {
                  return CollectionCard(collection: col);
                }).toList(),
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

class CollectionCard extends StatefulWidget {
  final Collection collection;

  const CollectionCard({super.key, required this.collection});

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () {
          // Placeholder for collection detail navigation
        },
        child: Stack(
          children: [
            // Background with gradient overlay
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    widget.collection.color.withAlpha((255 * 0.8).round()),
                    widget.collection.color.withAlpha((255 * 0.9).round()),
                  ],
                ),
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withAlpha((255 * 0.2).round()),
                  BlendMode.darken,
                ),
                child: Icon(
                  widget.collection.icon,
                  size: 64,
                  color: Colors.white.withAlpha((255 * 0.7).round()),
                ),
              ),
            ),
            // Hover effect overlay
            AnimatedOpacity(
              opacity: _isHovering ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                color: Colors.black.withAlpha((255 * 0.2).round()),
              ),
            ),
            // Collection name in center
            const Positioned.fill(
              child: Align(
                alignment: Alignment.center,
              ),
            ),
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
