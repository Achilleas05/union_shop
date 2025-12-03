import 'package:flutter/material.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/footer.dart';

class PrintShackAboutPage extends StatelessWidget {
  const PrintShackAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : 48.0,
                vertical: 32.0,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About Print Shack',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Welcome to Print Shack - your personalization destination!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'At Print Shack, we offer custom text printing services to make your items truly unique. Whether you want to add a personal touch to your clothing or create a special gift, we\'ve got you covered.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Our Services',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildServiceItem(
                        'Custom Text Printing',
                        'Add up to 3 lines of personalized text on front, back, or both sides',
                      ),
                      _buildServiceItem(
                        'Quick Turnaround',
                        'Most orders are processed within 2-3 business days',
                      ),
                      _buildServiceItem(
                        'Quality Guarantee',
                        'We use high-quality printing methods to ensure your text lasts',
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          border: Border.all(color: Colors.amber[200]!),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline,
                                color: Colors.amber[900], size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Please note: All personalized items are made to order and cannot be returned or exchanged. Please double-check your text before placing your order.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.amber[900],
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF4d2963), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
