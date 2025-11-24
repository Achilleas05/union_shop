import 'package:flutter/material.dart';
import 'package:union_shop/footer.dart';
import 'package:union_shop/header.dart';

class CollectionPage extends StatefulWidget {
  final String collectionTitle;
  const CollectionPage({super.key, required this.collectionTitle});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomHeader(),
            SizedBox(height: 40),
            Footer(),
          ],
        ),
      ),
    );
  }
}
