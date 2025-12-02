import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Product', () {
    test('should create a product with all required fields', () {
      const product = Product(
        id: 'test-1',
        name: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 29.99,
        description: 'A test product',
        sizes: ['S', 'M', 'L'],
        colors: ['Red', 'Blue'],
      );

      expect(product.id, 'test-1');
      expect(product.name, 'Test Product');
      expect(product.imageUrl, 'https://example.com/image.jpg');
      expect(product.price, 29.99);
      expect(product.description, 'A test product');
      expect(product.sizes, ['S', 'M', 'L']);
      expect(product.colors, ['Red', 'Blue']);
      expect(product.originalPrice, null);
      expect(product.tag, null);
    });

    test('should create a product with optional fields', () {
      const product = Product(
        id: 'test-2',
        name: 'Test Product 2',
        imageUrl: 'https://example.com/image2.jpg',
        price: 19.99,
        originalPrice: 39.99,
        tag: 'New',
        description: 'Another test product',
        sizes: ['One Size'],
        colors: ['Green'],
      );

      expect(product.originalPrice, 39.99);
      expect(product.tag, 'New');
    });

    group('isOnSale', () {
      test('should return true when price is less than originalPrice', () {
        const product = Product(
          id: 'sale-1',
          name: 'Sale Product',
          imageUrl: 'url',
          price: 15.00,
          originalPrice: 30.00,
          description: 'On sale',
          sizes: ['M'],
          colors: ['Black'],
        );

        expect(product.isOnSale, true);
      });

      test('should return false when price equals originalPrice', () {
        const product = Product(
          id: 'sale-2',
          name: 'No Sale Product',
          imageUrl: 'url',
          price: 30.00,
          originalPrice: 30.00,
          description: 'Not on sale',
          sizes: ['M'],
          colors: ['Black'],
        );

        expect(product.isOnSale, false);
      });

      test('should return false when originalPrice is null', () {
        const product = Product(
          id: 'sale-3',
          name: 'Regular Product',
          imageUrl: 'url',
          price: 30.00,
          description: 'Regular price',
          sizes: ['M'],
          colors: ['Black'],
        );

        expect(product.isOnSale, false);
      });

      test('should return false when price is greater than originalPrice', () {
        const product = Product(
          id: 'sale-4',
          name: 'Price Increase',
          imageUrl: 'url',
          price: 40.00,
          originalPrice: 30.00,
          description: 'Price went up',
          sizes: ['M'],
          colors: ['Black'],
        );

        expect(product.isOnSale, false);
      });
    });

    group('isNew', () {
      test('should return true when tag is "New"', () {
        const product = Product(
          id: 'new-1',
          name: 'New Product',
          imageUrl: 'url',
          price: 25.00,
          tag: 'New',
          description: 'Brand new',
          sizes: ['M'],
          colors: ['White'],
        );

        expect(product.isNew, true);
      });

      test('should return false when tag is not "New"', () {
        const product = Product(
          id: 'new-2',
          name: 'Old Product',
          imageUrl: 'url',
          price: 25.00,
          tag: 'Sale',
          description: 'On sale',
          sizes: ['M'],
          colors: ['White'],
        );

        expect(product.isNew, false);
      });

      test('should return false when tag is null', () {
        const product = Product(
          id: 'new-3',
          name: 'Regular Product',
          imageUrl: 'url',
          price: 25.00,
          description: 'Regular',
          sizes: ['M'],
          colors: ['White'],
        );

        expect(product.isNew, false);
      });
    });

    group('category - Clothing', () {
      test('should return "Clothing" for hoodie id', () {
        const product = Product(
          id: 'hoodie-001',
          name: 'Product',
          imageUrl: 'url',
          price: 50.00,
          description: 'desc',
          sizes: ['M'],
          colors: ['Blue'],
        );

        expect(product.category, 'Clothing');
      });

      test('should return "Clothing" for Hoodie in name', () {
        const product = Product(
          id: 'prod-001',
          name: 'Cool Hoodie',
          imageUrl: 'url',
          price: 50.00,
          description: 'desc',
          sizes: ['M'],
          colors: ['Blue'],
        );

        expect(product.category, 'Clothing');
      });

      test('should return "Clothing" for polo id', () {
        const product = Product(
          id: 'polo-001',
          name: 'Product',
          imageUrl: 'url',
          price: 40.00,
          description: 'desc',
          sizes: ['M'],
          colors: ['Red'],
        );

        expect(product.category, 'Clothing');
      });

      test('should return "Clothing" for Polo in name', () {
        const product = Product(
          id: 'prod-002',
          name: 'Classic Polo',
          imageUrl: 'url',
          price: 40.00,
          description: 'desc',
          sizes: ['M'],
          colors: ['Red'],
        );

        expect(product.category, 'Clothing');
      });

      test('should return "Clothing" for pants id', () {
        const product = Product(
          id: 'pants-001',
          name: 'Product',
          imageUrl: 'url',
          price: 60.00,
          description: 'desc',
          sizes: ['32'],
          colors: ['Black'],
        );

        expect(product.category, 'Clothing');
      });

      test('should return "Clothing" for Pants in name', () {
        const product = Product(
          id: 'prod-003',
          name: 'Dress Pants',
          imageUrl: 'url',
          price: 60.00,
          description: 'desc',
          sizes: ['32'],
          colors: ['Black'],
        );

        expect(product.category, 'Clothing');
      });

      test('should return "Clothing" for varsity id', () {
        const product = Product(
          id: 'varsity-001',
          name: 'Product',
          imageUrl: 'url',
          price: 80.00,
          description: 'desc',
          sizes: ['L'],
          colors: ['Navy'],
        );

        expect(product.category, 'Clothing');
      });

      test('should return "Clothing" for Varsity in name', () {
        const product = Product(
          id: 'prod-004',
          name: 'Varsity Jacket',
          imageUrl: 'url',
          price: 80.00,
          description: 'desc',
          sizes: ['L'],
          colors: ['Navy'],
        );

        expect(product.category, 'Clothing');
      });
    });

    group('category - Accessories', () {
      test('should return "Accessories" for beanie id', () {
        const product = Product(
          id: 'beanie-001',
          name: 'Product',
          imageUrl: 'url',
          price: 15.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Gray'],
        );

        expect(product.category, 'Accessories');
      });

      test('should return "Accessories" for Beanie in name', () {
        const product = Product(
          id: 'prod-005',
          name: 'Winter Beanie',
          imageUrl: 'url',
          price: 15.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Gray'],
        );

        expect(product.category, 'Accessories');
      });

      test('should return "Accessories" for bag id', () {
        const product = Product(
          id: 'bag-001',
          name: 'Product',
          imageUrl: 'url',
          price: 35.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Black'],
        );

        expect(product.category, 'Accessories');
      });

      test('should return "Accessories" for Bag in name', () {
        const product = Product(
          id: 'prod-006',
          name: 'Tote Bag',
          imageUrl: 'url',
          price: 35.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Black'],
        );

        expect(product.category, 'Accessories');
      });

      test('should return "Accessories" for keychain id', () {
        const product = Product(
          id: 'keychain-001',
          name: 'Product',
          imageUrl: 'url',
          price: 5.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Silver'],
        );

        expect(product.category, 'Accessories');
      });

      test('should return "Accessories" for Keychain in name', () {
        const product = Product(
          id: 'prod-007',
          name: 'Metal Keychain',
          imageUrl: 'url',
          price: 5.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Silver'],
        );

        expect(product.category, 'Accessories');
      });

      test('should return "Accessories" for grad-hat id', () {
        const product = Product(
          id: 'grad-hat-001',
          name: 'Product',
          imageUrl: 'url',
          price: 25.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Black'],
        );

        expect(product.category, 'Accessories');
      });

      test('should return "Accessories" for Graduation Cap in name', () {
        const product = Product(
          id: 'prod-008',
          name: 'Graduation Cap',
          imageUrl: 'url',
          price: 25.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Black'],
        );

        expect(product.category, 'Accessories');
      });
    });

    group('category - Study Supplies', () {
      test('should return "Study Supplies" for pen id', () {
        const product = Product(
          id: 'pen-001',
          name: 'Product',
          imageUrl: 'url',
          price: 2.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Blue'],
        );

        expect(product.category, 'Study Supplies');
      });

      test('should return "Study Supplies" for Pen in name', () {
        const product = Product(
          id: 'prod-009',
          name: 'Ballpoint Pen',
          imageUrl: 'url',
          price: 2.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Blue'],
        );

        expect(product.category, 'Study Supplies');
      });

      test('should return "Study Supplies" for calculator id', () {
        const product = Product(
          id: 'calculator-001',
          name: 'Product',
          imageUrl: 'url',
          price: 20.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Black'],
        );

        expect(product.category, 'Study Supplies');
      });

      test('should return "Study Supplies" for Calculator in name', () {
        const product = Product(
          id: 'prod-010',
          name: 'Scientific Calculator',
          imageUrl: 'url',
          price: 20.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Black'],
        );

        expect(product.category, 'Study Supplies');
      });

      test('should return "Study Supplies" for index-cards id', () {
        const product = Product(
          id: 'index-cards-001',
          name: 'Product',
          imageUrl: 'url',
          price: 3.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['White'],
        );

        expect(product.category, 'Study Supplies');
      });

      test('should return "Study Supplies" for Index Cards in name', () {
        const product = Product(
          id: 'prod-011',
          name: 'Index Cards Pack',
          imageUrl: 'url',
          price: 3.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['White'],
        );

        expect(product.category, 'Study Supplies');
      });

      test('should return "Study Supplies" for sticky-notes id', () {
        const product = Product(
          id: 'sticky-notes-001',
          name: 'Product',
          imageUrl: 'url',
          price: 4.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Yellow'],
        );

        expect(product.category, 'Study Supplies');
      });

      test('should return "Study Supplies" for Sticky Notes in name', () {
        const product = Product(
          id: 'prod-012',
          name: 'Sticky Notes Set',
          imageUrl: 'url',
          price: 4.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Yellow'],
        );

        expect(product.category, 'Study Supplies');
      });
    });

    group('category - Electronics', () {
      test('should return "Electronics" for laptop id', () {
        const product = Product(
          id: 'laptop-001',
          name: 'Product',
          imageUrl: 'url',
          price: 1200.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Silver'],
        );

        expect(product.category, 'Electronics');
      });

      test('should return "Electronics" for Laptop in name', () {
        const product = Product(
          id: 'prod-013',
          name: 'Gaming Laptop',
          imageUrl: 'url',
          price: 1200.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Silver'],
        );

        expect(product.category, 'Electronics');
      });

      test('should return "Electronics" for headset id', () {
        const product = Product(
          id: 'headset-001',
          name: 'Product',
          imageUrl: 'url',
          price: 80.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Black'],
        );

        expect(product.category, 'Electronics');
      });

      test('should return "Electronics" for Headset in name', () {
        const product = Product(
          id: 'prod-014',
          name: 'Wireless Headset',
          imageUrl: 'url',
          price: 80.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Black'],
        );

        expect(product.category, 'Electronics');
      });
    });

    group('category - Gift', () {
      test('should return "Gift" for magnet id', () {
        const product = Product(
          id: 'magnet-001',
          name: 'Product',
          imageUrl: 'url',
          price: 3.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Multi'],
        );

        expect(product.category, 'Gift');
      });

      test('should return "Gift" for Magnet in name', () {
        const product = Product(
          id: 'prod-015',
          name: 'Fridge Magnet',
          imageUrl: 'url',
          price: 3.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Multi'],
        );

        expect(product.category, 'Gift');
      });

      test('should return "Gift" for mug id', () {
        const product = Product(
          id: 'mug-001',
          name: 'Product',
          imageUrl: 'url',
          price: 12.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['White'],
        );

        expect(product.category, 'Gift');
      });

      test('should return "Gift" for Mug in name', () {
        const product = Product(
          id: 'prod-016',
          name: 'Coffee Mug',
          imageUrl: 'url',
          price: 12.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['White'],
        );

        expect(product.category, 'Gift');
      });

      test('should return "Gift" for frame id', () {
        const product = Product(
          id: 'frame-001',
          name: 'Product',
          imageUrl: 'url',
          price: 18.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Wood'],
        );

        expect(product.category, 'Gift');
      });

      test('should return "Gift" for Frame in name', () {
        const product = Product(
          id: 'prod-017',
          name: 'Photo Frame',
          imageUrl: 'url',
          price: 18.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Wood'],
        );

        expect(product.category, 'Gift');
      });
    });

    group('category - Other', () {
      test('should return "Other" for unrecognized id and name', () {
        const product = Product(
          id: 'unknown-001',
          name: 'Random Product',
          imageUrl: 'url',
          price: 10.00,
          description: 'desc',
          sizes: ['One Size'],
          colors: ['Various'],
        );

        expect(product.category, 'Other');
      });
    });

    group('title', () {
      test('should return null', () {
        const product = Product(
          id: 'test-1',
          name: 'Test Product',
          imageUrl: 'url',
          price: 20.00,
          description: 'desc',
          sizes: ['M'],
          colors: ['Red'],
        );

        expect(product.title, null);
      });
    });
  });
}
