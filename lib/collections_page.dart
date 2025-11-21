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

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}
