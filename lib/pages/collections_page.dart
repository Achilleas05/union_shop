import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/fixtures.dart';
import 'package:go_router/go_router.dart';

class CollectionService {
  Future<List<Collection>> getCollections() async {
    return collections;
  }
}

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  late List<Collection> _collections;
  final CollectionService _service = CollectionService();

  @override
  void initState() {
    super.initState();
    _loadCollections();
  }

  // This method demonstrates the dynamic data pattern
  void _loadCollections() async {
    final collections = await _service.getCollections();
    setState(() {
      _collections = collections;
    });
  }

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
                children: _collections.map((Collection col) {
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
          context.go('/collections/${widget.collection.id}');
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
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.collection.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${widget.collection.products.length} items',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
