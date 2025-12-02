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
    // Clothing
    if (id.startsWith('hoodie') || name.contains('Hoodie')) return 'Clothing';
    if (id.startsWith('polo') || name.contains('Polo')) return 'Clothing';
    if (id.startsWith('pants') || name.contains('Pants')) return 'Clothing';
    if (id.startsWith('varsity') || name.contains('Varsity')) return 'Clothing';

    // Accessories
    if (id.startsWith('beanie') || name.contains('Beanie')) {
      return 'Accessories';
    }
    if (id.startsWith('bag') || name.contains('Bag')) return 'Accessories';
    if (id.startsWith('keychain') || name.contains('Keychain')) {
      return 'Accessories';
    }
    if (id.startsWith('grad-hat') || name.contains('Graduation Cap')) {
      return 'Accessories';
    }

    // Study Supplies
    if (id.startsWith('pen') || name.contains('Pen')) return 'Study Supplies';
    if (id.startsWith('calculator') || name.contains('Calculator')) {
      return 'Study Supplies';
    }
    if (id.startsWith('index-cards') || name.contains('Index Cards')) {
      return 'Study Supplies';
    }
    if (id.startsWith('sticky-notes') || name.contains('Sticky Notes')) {
      return 'Study Supplies';
    }

    // Electronics
    if (id.startsWith('laptop') || name.contains('Laptop')) {
      return 'Electronics';
    }
    if (id.startsWith('headset') || name.contains('Headset')) {
      return 'Electronics';
    }

    // Gifts & Memorabilia
    if (id.startsWith('magnet') || name.contains('Magnet')) return 'Gift';
    if (id.startsWith('mug') || name.contains('Mug')) return 'Gift';
    if (id.startsWith('frame') || name.contains('Frame')) return 'Gift';

    return 'Other';
  }

  String? get title => null;
}
