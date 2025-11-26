class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double? originalPrice;
  final String? tag;

  final String description;
  final List<String> sizes;
  final List<String> colors;

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
}
