class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double? originalPrice;
  final String? tag;
  final String description;
  final List sizes;
  final List colors;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    this.tag,
    required this.description,
    required this.sizes,
    required this.colors,
  });

  // Simple derived flags to support filtering.
  bool get isOnSale => originalPrice != null && price < originalPrice!;
  bool get isNew => tag == 'New';

  // A category mapping based on id or name.
  String get category {
    if (id.startsWith('hoodie') || name.contains('Hoodie')) return 'Clothing';
    if (id.startsWith('beanie') || name.contains('Beanie')) {
      return 'Accessories';
    }
    if (id.startsWith('bag') || name.contains('Bag')) return 'Accessories';
    if (id.startsWith('magnet') || name.contains('Magnet')) return 'Gift';
    return 'Other';
  }
}
