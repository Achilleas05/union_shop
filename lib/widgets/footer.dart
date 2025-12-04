import 'package:flutter/material.dart';
import 'package:union_shop/widgets/search_overlay.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  bool _showSearch = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_showSearch) FocusScope.of(context).requestFocus();
    });
  }

  void _closeSearch() {
    setState(() {
      _showSearch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          final padding = isMobile ? 20.0 : 40.0;

          return Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_showSearch)
                  SearchOverlay(
                    onClose: _closeSearch,
                    useOverlay: false,
                  ),
                const SizedBox(height: 20),
                isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildOpeningHours(),
                          const SizedBox(height: 32),
                          _buildHelpInfo(),
                          const SizedBox(height: 32),
                          _buildLatestOffers(),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildOpeningHours()),
                          const SizedBox(width: 40),
                          Expanded(child: _buildHelpInfo()),
                          const SizedBox(width: 40),
                          Expanded(child: _buildLatestOffers()),
                        ],
                      ),
                const SizedBox(height: 40),
                const Divider(height: 1, color: Colors.grey),
                const SizedBox(height: 20),
                const Text(
                  '© 2025 UPSU. All rights reserved.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOpeningHours() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    );
  }

  Widget _buildHelpInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Help and Information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        _buildFooterLink('Search'),
        _buildFooterLink('Terms & Conditions of Sale Policy'),
      ],
    );
  }

  Widget _buildLatestOffers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Latest Offers',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Email address',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[600]!,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                // Placeholder for subscribe functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4d2963),
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: const Text(
                'SUBSCRIBE',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextButton(
        onPressed: text == 'Search'
            ? () => setState(() => _showSearch = true)
            : () {}, // Placeholder for future functionality
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF4d2963),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
