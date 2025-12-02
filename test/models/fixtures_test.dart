import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:union_shop/models/fixtures.dart';

void main() {
  group('Products Fixtures Tests', () {
    test('products list should not be empty', () {
      expect(products, isNotEmpty);
      expect(products.length, 17);
    });

    test('all products should have valid required fields', () {
      for (final product in products) {
        expect(product.id, isNotEmpty);
        expect(product.name, isNotEmpty);
        expect(product.imageUrl, isNotEmpty);
        expect(product.price, greaterThan(0));
        expect(product.description, isNotEmpty);
        expect(product.sizes, isNotEmpty);
        expect(product.colors, isNotEmpty);
      }
    });

    test('products with sale tag should have original price', () {
      final saleProducts = products.where((p) => p.tag == 'Sale').toList();
      expect(saleProducts, isNotEmpty);

      for (final product in saleProducts) {
        expect(product.originalPrice, isNotNull);
        expect(product.originalPrice!, greaterThan(product.price));
      }
    });

    test('hoodie product should have correct properties', () {
      final hoodie = products.firstWhere((p) => p.id == 'hoodie-1');
      expect(hoodie.name, 'University Hoodie Navy');
      expect(hoodie.price, 34.99);
      expect(hoodie.originalPrice, 44.99);
      expect(hoodie.tag, 'Sale');
      expect(hoodie.sizes, ['S', 'M', 'L', 'XL']);
      expect(hoodie.colors, ['Navy', 'Black', 'Grey']);
    });

    test('beanie product should have correct properties', () {
      final beanie = products.firstWhere((p) => p.id == 'beanie-1');
      expect(beanie.name, 'Pom Pom Beanie');
      expect(beanie.price, 12.99);
      expect(beanie.tag, 'New');
      expect(beanie.sizes, ['One Size']);
      expect(beanie.colors, ['Navy', 'Black', 'Cream', 'Maroon']);
    });

    test('polo product should have correct properties', () {
      final polo = products.firstWhere((p) => p.id == 'polo-1');
      expect(polo.name, 'University Polo Shirt');
      expect(polo.price, 24.99);
      expect(polo.tag, isNull);
      expect(polo.sizes, ['S', 'M', 'L', 'XL', 'XXL']);
    });

    test('laptop product should have sale properties', () {
      final laptop = products.firstWhere((p) => p.id == 'laptop-1');
      expect(laptop.price, 599.99);
      expect(laptop.originalPrice, 699.99);
      expect(laptop.tag, 'Sale');
    });

    test('all product IDs should be unique', () {
      final ids = products.map((p) => p.id).toList();
      final uniqueIds = ids.toSet();
      expect(ids.length, uniqueIds.length);
    });

    test('products with tag New should exist', () {
      final newProducts = products.where((p) => p.tag == 'New').toList();
      expect(newProducts.length, 2); // Beanie and Varsity
      expect(newProducts.any((p) => p.id == 'beanie-1'), isTrue);
      expect(newProducts.any((p) => p.id == 'varsity-1'), isTrue);
    });

    test('one size products should have correct size specification', () {
      final oneSizeProducts = products
          .where((p) => p.sizes.length == 1 && p.sizes.first == 'One Size')
          .toList();
      expect(oneSizeProducts, isNotEmpty);
      expect(oneSizeProducts.any((p) => p.id == 'beanie-1'), isTrue);
      expect(oneSizeProducts.any((p) => p.id == 'bag-1'), isTrue);
    });

    test('all prices should be positive and reasonable', () {
      for (final product in products) {
        expect(product.price, greaterThan(0));
        expect(product.price, lessThan(10000));
        if (product.originalPrice != null) {
          expect(product.originalPrice, greaterThan(product.price));
        }
      }
    });

    test('specific product categories should exist', () {
      expect(products.any((p) => p.id.contains('hoodie')), isTrue);
      expect(products.any((p) => p.id.contains('laptop')), isTrue);
      expect(products.any((p) => p.id.contains('mug')), isTrue);
      expect(products.any((p) => p.id.contains('pen')), isTrue);
    });
  });

  group('Collections Fixtures Tests', () {
    test('collections list should not be empty', () {
      expect(collections, isNotEmpty);
      expect(collections.length, 7);
    });

    test('all collections should have valid required fields', () {
      for (final collection in collections) {
        expect(collection.id, isNotEmpty);
        expect(collection.name, isNotEmpty);
        expect(collection.color, isNotNull);
        expect(collection.icon, isNotNull);
        expect(collection.products, isNotEmpty);
      }
    });

    test('all collection IDs should be unique', () {
      final ids = collections.map((c) => c.id).toList();
      final uniqueIds = ids.toSet();
      expect(ids.length, uniqueIds.length);
    });

    test('essential range collection should have correct products', () {
      final essentialRange =
          collections.firstWhere((c) => c.id == 'essential-range');
      expect(essentialRange.name, 'Essential Range');
      expect(essentialRange.color, const Color(0xFF4d2963));
      expect(essentialRange.icon, Icons.star_border);
      expect(essentialRange.products.length, 4);
      expect(essentialRange.products[0].id, 'hoodie-1');
      expect(essentialRange.products[1].id, 'beanie-1');
      expect(essentialRange.products[2].id, 'bag-1');
      expect(essentialRange.products[3].id, 'pen-1');
    });

    test('university clothing collection should have correct products', () {
      final clothing =
          collections.firstWhere((c) => c.id == 'university-clothing');
      expect(clothing.products.length, 5);
      expect(clothing.color, const Color(0xFF2E8B57));
      expect(clothing.icon, Icons.flag);
    });

    test('study supplies collection should have correct products', () {
      final studySupplies =
          collections.firstWhere((c) => c.id == 'study-supplies');
      expect(studySupplies.products.length, 4);
      expect(studySupplies.color, const Color(0xFF1E90FF));
      expect(studySupplies.icon, Icons.school);
      expect(studySupplies.products[0].id, 'pen-1');
      expect(studySupplies.products[1].id, 'calculator-1');
    });

    test('tech essentials collection should have correct products', () {
      final techEssentials =
          collections.firstWhere((c) => c.id == 'tech-essentials');
      expect(techEssentials.products.length, 2);
      expect(techEssentials.products[0].id, 'laptop-1');
      expect(techEssentials.products[1].id, 'headset-1');
    });

    test('gift shop collection should have correct products', () {
      final giftShop = collections.firstWhere((c) => c.id == 'gift-shop');
      expect(giftShop.products.length, 4);
      expect(giftShop.color, const Color(0xFFFF6347));
      expect(giftShop.icon, Icons.card_giftcard);
    });

    test('graduation collection should have correct products', () {
      final graduation = collections.firstWhere((c) => c.id == 'graduation');
      expect(graduation.products.length, 2);
      expect(graduation.products[0].id, 'grad-hat-1');
      expect(graduation.products[1].id, 'frame-1');
      expect(graduation.icon, Icons.school_outlined);
    });

    test('sale items collection should contain only sale products', () {
      final saleItems = collections.firstWhere((c) => c.id == 'sale-items');
      expect(saleItems.products.length, 2);
      expect(saleItems.color, const Color(0xFFDC143C));
      expect(saleItems.icon, Icons.local_offer);

      for (final product in saleItems.products) {
        expect(product.tag, 'Sale');
        expect(product.originalPrice, isNotNull);
      }
    });

    test('all products in collections should exist in products list', () {
      for (final collection in collections) {
        for (final product in collection.products) {
          expect(products.contains(product), isTrue);
        }
      }
    });

    test('collection colors should be valid Color objects', () {
      for (final collection in collections) {
        expect(collection.color.r, isNotNull);
        expect((collection.color.a * 255.0).round() & 0xff, greaterThan(0));
      }
    });

    test('collection icons should be valid IconData objects', () {
      for (final collection in collections) {
        expect(collection.icon.codePoint, greaterThan(0));
      }
    });

    test('same product can appear in multiple collections', () {
      final hoodie = products.firstWhere((p) => p.id == 'hoodie-1');
      final collectionsWithHoodie =
          collections.where((c) => c.products.contains(hoodie)).toList();
      expect(collectionsWithHoodie.length, greaterThanOrEqualTo(2));
    });
  });

  group('Data Integrity Tests', () {
    test('product indices used in collections should be valid', () {
      // Verify that hardcoded indices match actual product positions
      expect(products[0].id, 'hoodie-1');
      expect(products[1].id, 'beanie-1');
      expect(products[2].id, 'polo-1');
      expect(products[5].id, 'grad-hat-1');
      expect(products[6].id, 'bag-1');
      expect(products[8].id, 'pen-1');
      expect(products[12].id, 'laptop-1');
      expect(products[16].id, 'frame-1');
    });

    test('no null values in required fields', () {
      for (final product in products) {
        expect(product.id, isNotNull);
        expect(product.name, isNotNull);
        expect(product.imageUrl, isNotNull);
        expect(product.price, isNotNull);
        expect(product.description, isNotNull);
        expect(product.sizes, isNotNull);
        expect(product.colors, isNotNull);
      }
    });

    test('image paths follow correct format', () {
      for (final product in products) {
        expect(product.imageUrl.startsWith('assets/'), isTrue);
        expect(product.imageUrl.endsWith('.png'), isTrue);
      }
    });

    test('all collections have at least one product', () {
      for (final collection in collections) {
        expect(collection.products.length, greaterThan(0));
      }
    });
  });
}
