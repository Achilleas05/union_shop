import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(40),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SizedBox()), // Opening Hours
              SizedBox(width: 40),
              Expanded(child: SizedBox()), // Help & Info
              SizedBox(width: 40),
              Expanded(child: SizedBox()), // Latest Offers
            ],
          ),
        ],
      ),
    );
  }
}
