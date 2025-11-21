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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Latest Offers',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Opening Hours',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '❄️ Winter Break Closure Dates ❄️',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Closing 4pm 19/12/2025',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Reopening 10am 05/01/2026',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Last post date: 12pm on 18/12/2025',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 16),
                    Divider(height: 1, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      '(Term Time)',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Monday - Friday 10am - 4pm',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '(Outside of Term Time / Consolidation Weeks)',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Monday - Friday 10am - 3pm',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Purchase online 24/7',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Help and Information',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text('Search'),
                    SizedBox(height: 8),
                    Text('Terms & Conditions of Sale Policy'),
                    SizedBox(height: 12),
                    Text(
                      'Latest Offers',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Email address',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 40),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Latest Offers',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
