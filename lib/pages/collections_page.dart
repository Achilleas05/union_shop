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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 900;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            const CustomHeader(),

            // Page Title - Centered
            Container(
              padding: EdgeInsets.symmetric(vertical: isMobile ? 24 : 40),
              child: Text(
                'Collections',
                style: TextStyle(
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // Collections Grid
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : (isTablet ? 32 : 72)),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isMobile ? 2 : 3,
                crossAxisSpacing: isMobile ? 12 : 16,
                mainAxisSpacing: isMobile ? 12 : 16,
                childAspectRatio: isMobile ? 1.0 : 1.5,
                children: _collections.map((Collection col) {
                  return CollectionCard(collection: col);
                }).toList(),
              ),
            ),
            SizedBox(height: isMobile ? 40 : 60),

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

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
                  size: isMobile ? 48 : 64,
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
                  style: TextStyle(
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: const [
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
              top: isMobile ? 8 : 12,
              right: isMobile ? 8 : 12,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 6 : 8,
                  vertical: isMobile ? 3 : 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha((255 * 0.7).round()),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${widget.collection.products.length} items',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 10 : 12,
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
