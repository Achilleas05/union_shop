import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Collection Model Tests', () {
    // Sample data for testing
    const sampleProduct1 = Product(
      id: 'p1',
      name: 'Test Product 1',
      price: 29.99,
      imageUrl: 'https://example.com/image1.jpg',
      description: 'Test description 1',
      sizes: [],
      colors: [],
    );

    const sampleProduct2 = Product(
      id: 'p2',
      name: 'Test Product 2',
      price: 49.99,
      imageUrl: 'https://example.com/image2.jpg',
      description: 'Test description 2',
      sizes: [],
      colors: [],
    );

    group('Constructor Tests', () {
      test('should create Collection with all required fields', () {
        const collection = Collection(
          id: 'c1',
          name: 'Electronics',
          color: Colors.blue,
          icon: Icons.phone_android,
          products: [sampleProduct1, sampleProduct2],
        );

        expect(collection.id, 'c1');
        expect(collection.name, 'Electronics');
        expect(collection.color, Colors.blue);
        expect(collection.icon, Icons.phone_android);
        expect(collection.products, [sampleProduct1, sampleProduct2]);
        expect(collection.products.length, 2);
      });

      test('should create Collection with empty products list', () {
        const collection = Collection(
          id: 'c2',
          name: 'Empty Collection',
          color: Colors.red,
          icon: Icons.category,
          products: [],
        );

        expect(collection.products, isEmpty);
        expect(collection.products.length, 0);
      });

      test('should create const Collection', () {
        const collection = Collection(
          id: 'c3',
          name: 'Const Collection',
          color: Colors.green,
          icon: Icons.shopping_bag,
          products: [],
        );

        expect(collection.id, 'c3');
        expect(collection.name, 'Const Collection');
      });
    });

    group('Property Tests', () {
      late Collection testCollection;

      setUp(() {
        testCollection = const Collection(
          id: 'test-id',
          name: 'Test Collection',
          color: Colors.purple,
          icon: Icons.star,
          products: [sampleProduct1],
        );
      });

      test('should have correct id property', () {
        expect(testCollection.id, 'test-id');
        expect(testCollection.id, isA<String>());
      });

      test('should have correct name property', () {
        expect(testCollection.name, 'Test Collection');
        expect(testCollection.name, isA<String>());
      });

      test('should have correct color property', () {
        expect(testCollection.color, Colors.purple);
        expect(testCollection.color, isA<Color>());
      });

      test('should have correct icon property', () {
        expect(testCollection.icon, Icons.star);
        expect(testCollection.icon, isA<IconData>());
      });

      test('should have correct products property', () {
        expect(testCollection.products, isA<List<Product>>());
        expect(testCollection.products.length, 1);
        expect(testCollection.products.first, sampleProduct1);
      });
    });

    group('Edge Cases', () {
      test('should handle special characters in id and name', () {
        const collection = Collection(
          id: 'id-with-@#\$%',
          name: 'Name with émojis 🎉',
          color: Colors.amber,
          icon: Icons.emoji_emotions,
          products: [],
        );

        expect(collection.id, 'id-with-@#\$%');
        expect(collection.name, 'Name with émojis 🎉');
      });

      test('should handle very long id and name strings', () {
        final longString = 'a' * 1000;
        final collection = Collection(
          id: longString,
          name: longString,
          color: Colors.teal,
          icon: Icons.text_fields,
          products: [],
        );

        expect(collection.id.length, 1000);
        expect(collection.name.length, 1000);
      });

      test('should handle large products list', () {
        final manyProducts = List.generate(
          100,
          (index) => Product(
            id: 'p$index',
            name: 'Product $index',
            price: index.toDouble(),
            imageUrl: 'https://example.com/image$index.jpg',
            description: 'Description $index',
            sizes: [],
            colors: [],
          ),
        );

        final collection = Collection(
          id: 'large-collection',
          name: 'Large Collection',
          color: Colors.orange,
          icon: Icons.inventory,
          products: manyProducts,
        );

        expect(collection.products.length, 100);
        expect(collection.products.first.id, 'p0');
        expect(collection.products.last.id, 'p99');
      });
    });

    group('Immutability Tests', () {
      test('should be immutable (const constructor)', () {
        const collection1 = Collection(
          id: 'c1',
          name: 'Collection',
          color: Colors.blue,
          icon: Icons.category,
          products: [],
        );

        const collection2 = Collection(
          id: 'c1',
          name: 'Collection',
          color: Colors.blue,
          icon: Icons.category,
          products: [],
        );

        expect(identical(collection1, collection2), isTrue);
      });
    });

    group('Different Color Values', () {
      test('should handle different color types', () {
        final collections = [
          const Collection(
            id: '1',
            name: 'Primary Color',
            color: Colors.red,
            icon: Icons.palette,
            products: [],
          ),
          const Collection(
            id: '2',
            name: 'Custom Color',
            color: Color(0xFF123456),
            icon: Icons.color_lens,
            products: [],
          ),
          const Collection(
            id: '3',
            name: 'Transparent',
            color: Colors.transparent,
            icon: Icons.opacity,
            products: [],
          ),
        ];

        expect(collections[0].color, Colors.red);
        expect(collections[1].color, const Color(0xFF123456));
        expect(collections[2].color, Colors.transparent);
      });
    });

    group('Different Icon Values', () {
      test('should handle different icon types', () {
        final icons = [
          Icons.home,
          Icons.shopping_cart,
          Icons.favorite,
          Icons.account_circle,
        ];

        for (var i = 0; i < icons.length; i++) {
          final collection = Collection(
            id: 'icon-$i',
            name: 'Icon Test $i',
            color: Colors.grey,
            icon: icons[i],
            products: [],
          );

          expect(collection.icon, icons[i]);
        }
      });
    });

    group('Products List Manipulation', () {
      test('should maintain products list reference', () {
        final productsList = [sampleProduct1, sampleProduct2];
        final collection = Collection(
          id: 'ref-test',
          name: 'Reference Test',
          color: Colors.cyan,
          icon: Icons.link,
          products: productsList,
        );

        expect(collection.products, same(productsList));
      });

      test('should access products by index', () {
        const collection = Collection(
          id: 'index-test',
          name: 'Index Test',
          color: Colors.lime,
          icon: Icons.format_list_numbered,
          products: [sampleProduct1, sampleProduct2],
        );

        expect(collection.products[0], sampleProduct1);
        expect(collection.products[1], sampleProduct2);
        expect(collection.products[0].id, 'p1');
        expect(collection.products[1].price, 49.99);
      });
    });

    group('Type Verification', () {
      test('should verify all field types', () {
        const collection = Collection(
          id: 'type-test',
          name: 'Type Test',
          color: Colors.indigo,
          icon: Icons.check_circle,
          products: [sampleProduct1],
        );

        expect(collection, isA<Collection>());
        expect(collection.id, isA<String>());
        expect(collection.name, isA<String>());
        expect(collection.color, isA<Color>());
        expect(collection.icon, isA<IconData>());
        expect(collection.products, isA<List<Product>>());
      });
    });

    group('Getter Methods', () {
      test('productCount should return correct count', () {
        const emptyCollection = Collection(
          id: 'empty',
          name: 'Empty',
          color: Colors.grey,
          icon: Icons.inbox,
          products: [],
        );

        const fullCollection = Collection(
          id: 'full',
          name: 'Full',
          color: Colors.blue,
          icon: Icons.inventory,
          products: [sampleProduct1, sampleProduct2],
        );

        expect(emptyCollection.productCount, 0);
        expect(fullCollection.productCount, 2);
      });

      test('isEmpty and isNotEmpty should work correctly', () {
        const emptyCollection = Collection(
          id: 'empty',
          name: 'Empty',
          color: Colors.grey,
          icon: Icons.inbox,
          products: [],
        );

        const fullCollection = Collection(
          id: 'full',
          name: 'Full',
          color: Colors.blue,
          icon: Icons.inventory,
          products: [sampleProduct1],
        );

        expect(emptyCollection.isEmpty, isTrue);
        expect(emptyCollection.isNotEmpty, isFalse);
        expect(fullCollection.isEmpty, isFalse);
        expect(fullCollection.isNotEmpty, isTrue);
      });
    });

    group('getProductById Method', () {
      const collection = Collection(
        id: 'test',
        name: 'Test',
        color: Colors.blue,
        icon: Icons.search,
        products: [sampleProduct1, sampleProduct2],
      );

      test('should find existing product', () {
        final result = collection.getProductById('p1');
        expect(result, isNotNull);
        expect(result?.id, 'p1');
        expect(result?.name, 'Test Product 1');
      });

      test('should return null for non-existing product', () {
        final result = collection.getProductById('non-existent');
        expect(result, isNull);
      });
    });

    group('copyWith Method', () {
      const original = Collection(
        id: 'orig',
        name: 'Original',
        color: Colors.red,
        icon: Icons.copy,
        products: [sampleProduct1],
      );

      test('should copy with new id', () {
        final copied = original.copyWith(id: 'new-id');
        expect(copied.id, 'new-id');
        expect(copied.name, 'Original');
        expect(copied.color, Colors.red);
      });

      test('should copy with new name', () {
        final copied = original.copyWith(name: 'New Name');
        expect(copied.id, 'orig');
        expect(copied.name, 'New Name');
      });

      test('should copy with new color', () {
        final copied = original.copyWith(color: Colors.blue);
        expect(copied.color, Colors.blue);
        expect(copied.name, 'Original');
      });

      test('should copy with new icon', () {
        final copied = original.copyWith(icon: Icons.edit);
        expect(copied.icon, Icons.edit);
        expect(copied.id, 'orig');
      });

      test('should copy with new products', () {
        final copied = original.copyWith(products: [sampleProduct2]);
        expect(copied.products.length, 1);
        expect(copied.products.first.id, 'p2');
      });

      test('should copy with multiple fields', () {
        final copied = original.copyWith(
          id: 'multi',
          name: 'Multi',
          color: Colors.green,
        );
        expect(copied.id, 'multi');
        expect(copied.name, 'Multi');
        expect(copied.color, Colors.green);
        expect(copied.icon, Icons.copy);
      });
    });

    group('Equality Operator', () {
      test('should be equal for identical collections', () {
        const collection1 = Collection(
          id: 'eq1',
          name: 'Equal',
          color: Colors.blue,
          icon: Icons.check,
          products: [sampleProduct1],
        );

        const collection2 = Collection(
          id: 'eq1',
          name: 'Equal',
          color: Colors.blue,
          icon: Icons.check,
          products: [sampleProduct1],
        );

        expect(collection1 == collection2, isTrue);
      });

      test('should not be equal for different ids', () {
        const collection1 = Collection(
          id: 'id1',
          name: 'Equal',
          color: Colors.blue,
          icon: Icons.check,
          products: [],
        );

        const collection2 = Collection(
          id: 'id2',
          name: 'Equal',
          color: Colors.blue,
          icon: Icons.check,
          products: [],
        );

        expect(collection1 == collection2, isFalse);
      });

      test('should not be equal for different products', () {
        const collection1 = Collection(
          id: 'id',
          name: 'Name',
          color: Colors.blue,
          icon: Icons.check,
          products: [sampleProduct1],
        );

        const collection2 = Collection(
          id: 'id',
          name: 'Name',
          color: Colors.blue,
          icon: Icons.check,
          products: [sampleProduct2],
        );

        expect(collection1 == collection2, isFalse);
      });
    });

    group('hashCode', () {
      test('should have same hashCode for equal collections', () {
        const collection1 = Collection(
          id: 'hash',
          name: 'Hash',
          color: Colors.blue,
          icon: Icons.tag,
          products: [],
        );

        const collection2 = Collection(
          id: 'hash',
          name: 'Hash',
          color: Colors.blue,
          icon: Icons.tag,
          products: [],
        );

        expect(collection1.hashCode, collection2.hashCode);
      });
    });

    group('toString Method', () {
      test('should return string representation', () {
        const collection = Collection(
          id: 'str-test',
          name: 'String Test',
          color: Colors.amber,
          icon: Icons.text_fields,
          products: [sampleProduct1, sampleProduct2],
        );

        final str = collection.toString();
        expect(str, contains('str-test'));
        expect(str, contains('String Test'));
        expect(str, contains('2'));
      });
    });
  });
}
