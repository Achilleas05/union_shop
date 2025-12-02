import 'package:flutter/material.dart';
import 'product.dart';
import 'collection.dart';

const List<Product> products = [
  // Clothing
  Product(
    id: 'hoodie-1',
    name: 'University Hoodie Navy',
    imageUrl: 'assets/portsmouth_hoodie.png',
    price: 34.99,
    originalPrice: 44.99,
    tag: 'Sale',
    description:
        'A comfortable and stylish university hoodie perfect for campus life. Made from high-quality cotton blend with university branding.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Navy', 'Black', 'Grey'],
  ),
  Product(
    id: 'beanie-1',
    name: 'Pom Pom Beanie',
    imageUrl: 'assets/portsmouth_beanie.png',
    price: 12.99,
    tag: 'New',
    description:
        'Warm and cozy beanie with a cute pom pom. Perfect for cold weather on campus.',
    sizes: ['One Size'],
    colors: ['Navy', 'Black', 'Cream', 'Maroon'],
  ),
  Product(
    id: 'polo-1',
    name: 'University Polo Shirt',
    imageUrl: 'assets/portsmouth_polo.png',
    price: 24.99,
    description:
        'Classic polo shirt with university logo. Perfect for a smart casual look.',
    sizes: ['S', 'M', 'L', 'XL', 'XXL'],
    colors: ['Navy', 'White', 'Grey'],
  ),
  Product(
    id: 'pants-1',
    name: 'University Track Pants',
    imageUrl: 'assets/portsmouth_pants.png',
    price: 29.99,
    description:
        'Comfortable track pants with university branding. Ideal for sports and leisure.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Navy', 'Black', 'Grey'],
  ),
  Product(
    id: 'varsity-1',
    name: 'Varsity Jacket',
    imageUrl: 'assets/portsmouth_varsity.png',
    price: 54.99,
    tag: 'New',
    description:
        'Classic varsity jacket with university colors and patches. Premium quality and style.',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Navy/White', 'Black/Grey'],
  ),
  Product(
    id: 'grad-hat-1',
    name: 'Graduation Cap',
    imageUrl: 'assets/portsmouth_grad_hat.png',
    price: 19.99,
    description:
        'Traditional graduation cap for your special day. University standard.',
    sizes: ['One Size'],
    colors: ['Black'],
  ),
  // Bags & Accessories
  Product(
    id: 'bag-1',
    name: 'UPSU Tote Bag',
    imageUrl: 'assets/portsmouth_bag.png',
    price: 12.99,
    description:
        'Durable and spacious tote bag with UPSU branding. Perfect for carrying books and essentials.',
    sizes: ['One Size'],
    colors: ['Natural', 'Black', 'Navy'],
  ),
  Product(
    id: 'keychain-1',
    name: 'University Keychain Set',
    imageUrl: 'assets/portsmouth_keychains.png',
    price: 5.99,
    description:
        'Set of university-branded keychains. Great for keeping your keys organized.',
    sizes: ['One Size'],
    colors: ['Assorted'],
  ),
  // Study Supplies
  Product(
    id: 'pen-1',
    name: 'University Pen',
    imageUrl: 'assets/portsmouth_pen.png',
    price: 2.99,
    description:
        'Quality ballpoint pen with university branding. Smooth writing experience.',
    sizes: ['One Size'],
    colors: ['Navy', 'Black'],
  ),
  Product(
    id: 'calculator-1',
    name: 'Scientific Calculator',
    imageUrl: 'assets/portsmouth_calculator.png',
    price: 15.99,
    description:
        'Essential scientific calculator for your studies. University recommended.',
    sizes: ['One Size'],
    colors: ['Black'],
  ),
  Product(
    id: 'index-cards-1',
    name: 'Study Index Cards',
    imageUrl: 'assets/portsmouth_index_cards.png',
    price: 4.99,
    description:
        'Pack of index cards for effective study and revision. 100 cards per pack.',
    sizes: ['One Size'],
    colors: ['White', 'Assorted'],
  ),
  Product(
    id: 'sticky-notes-1',
    name: 'Sticky Notes Set',
    imageUrl: 'assets/portsmouth_stickynotes.png',
    price: 6.99,
    description:
        'Colorful sticky notes set for organizing your study materials and notes.',
    sizes: ['One Size'],
    colors: ['Multicolor'],
  ),
  // Electronics & Tech
  Product(
    id: 'laptop-1',
    name: 'Student Laptop',
    imageUrl: 'assets/portsmouth_laptop.png',
    price: 599.99,
    tag: 'Sale',
    originalPrice: 699.99,
    description:
        'High-performance laptop perfect for students. Great for coursework and assignments.',
    sizes: ['One Size'],
    colors: ['Silver', 'Space Grey'],
  ),
  Product(
    id: 'headset-1',
    name: 'Study Headset',
    imageUrl: 'assets/portsmouth_headset.png',
    price: 39.99,
    description:
        'Comfortable headset with noise cancellation. Perfect for online lectures and study sessions.',
    sizes: ['One Size'],
    colors: ['Black', 'White'],
  ),
  // Gifts & Memorabilia
  Product(
    id: 'magnet-1',
    name: 'Portsmouth City Magnet',
    imageUrl: 'assets/portsmouth_magnet.png',
    price: 3.50,
    description:
        'Colorful Portsmouth city landmark magnet. Great souvenir or gift.',
    sizes: ['One Size'],
    colors: ['Multicolor'],
  ),
  Product(
    id: 'mug-1',
    name: 'University Mug',
    imageUrl: 'assets/portsmouth_mug.png',
    price: 8.99,
    description:
        'Ceramic mug with university logo. Perfect for your morning coffee or tea.',
    sizes: ['One Size'],
    colors: ['Navy', 'White', 'Black'],
  ),
  Product(
    id: 'frame-1',
    name: 'Graduation Photo Frame',
    imageUrl: 'assets/portsmouth_frame.png',
    price: 14.99,
    description:
        'Elegant photo frame for your graduation memories. University themed design.',
    sizes: ['One Size'],
    colors: ['Black', 'Silver'],
  ),
];

final List<Collection> collections = [
  Collection(
    id: 'essential-range',
    name: 'Essential Range',
    color: const Color(0xFF4d2963),
    icon: Icons.star_border,
    products: [
      products[0],
      products[1],
      products[6],
      products[8]
    ], // Hoodie, Beanie, Bag, Pen
  ),
  Collection(
    id: 'university-clothing',
    name: 'University Clothing',
    color: const Color(0xFF2E8B57),
    icon: Icons.flag,
    products: [
      products[0],
      products[1],
      products[2],
      products[3],
      products[4]
    ], // Hoodie, Beanie, Polo, Pants, Varsity
  ),
  Collection(
    id: 'study-supplies',
    name: 'Study Supplies',
    color: const Color(0xFF1E90FF),
    icon: Icons.school,
    products: [
      products[8],
      products[9],
      products[10],
      products[11]
    ], // Pen, Calculator, Index Cards, Sticky Notes
  ),
  Collection(
    id: 'tech-essentials',
    name: 'Tech Essentials',
    color: const Color(0xFF8A2BE2),
    icon: Icons.laptop,
    products: [products[12], products[13]], // Laptop, Headset
  ),
  Collection(
    id: 'gift-shop',
    name: 'Gift Shop',
    color: const Color(0xFFFF6347),
    icon: Icons.card_giftcard,
    products: [
      products[6],
      products[14],
      products[15],
      products[16]
    ], // Bag, Magnet, Mug, Frame
  ),
  Collection(
    id: 'graduation',
    name: 'Graduation',
    color: const Color(0xFFFFD700),
    icon: Icons.school_outlined,
    products: [products[5], products[16]], // Grad Hat, Frame
  ),
  Collection(
    id: 'sale-items',
    name: 'Sale Items',
    color: const Color(0xFFDC143C),
    icon: Icons.local_offer,
    products: [products[0], products[12]], // Hoodie, Laptop
  ),
];
