import 'package:flutter/material.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/footer.dart'; // Add this import

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomHeader(),
            Container(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: const Text(
                'About us',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 900, // keeps content centered like the website
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16), // Add this spacing
                  Text(
                    'Welcome to the Union Shop!\n\n' // Move this to main text
                    'We\'re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive personalisation service!\n\n'
                    'All online purchases are available for delivery or instore collection!\n\n'
                    'We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don\'t hesitate to contact us at hello@upsu.net.\n\n'
                    'Happy shopping!\n\n'
                    'The Union Shop & Reception Team',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 40), // Add spacing at the bottom
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
