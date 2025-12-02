import 'package:flutter/material.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/footer.dart';

class PrintShackPage extends StatefulWidget {
  const PrintShackPage({super.key});

  @override
  State<PrintShackPage> createState() => _PrintShackPageState();
}

class _PrintShackPageState extends State<PrintShackPage> {
  String _config = '1_front';
  int _quantity = 1;

  int get _lineCount => int.parse(_config.split('_')[0]);
  String get _locationKey => _config.split('_')[1];

  String get locationLabel {
    switch (_locationKey) {
      case 'back':
        return 'Back';
      case 'both':
        return 'Front & Back';
      default:
        return 'Front';
    }
  }

  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  double get price {
    double base = 3.0;
    if (_lineCount == 2) base = 4.0;
    if (_lineCount == 3) base = 5.0;
    if (_locationKey == 'both') base += 2.0;
    return base;
  }

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
                  child: _buildLayout(isMobile),
                ),
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildLayout(bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImageSection(),
          const SizedBox(height: 32),
          _buildProductInfo(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildImageSection()),
        const SizedBox(width: 64),
        Expanded(child: _buildProductInfo()),
      ],
    );
  }

  Widget _buildImageSection() {
    final lines = [
      _controllers[0].text.trim(),
      if (_lineCount >= 2) _controllers[1].text.trim(),
      if (_lineCount >= 3) _controllers[2].text.trim(),
    ].where((line) => line.isNotEmpty).toList();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        color: Colors.grey[50],
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    locationLabel.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  for (var i = 0; i < lines.length; i++) ...[
                    if (i > 0) const SizedBox(height: 8),
                    Text(
                      lines[i].toUpperCase(),
                      style: TextStyle(
                        fontSize: i == 0 ? 24 : 20,
                        fontWeight: i == 0 ? FontWeight.bold : FontWeight.w600,
                        letterSpacing: i == 0 ? 2 : 1.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personalise Text',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '£${price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4d2963),
          ),
        ),
        const SizedBox(height: 24),
        _buildWarning(),
        const SizedBox(height: 32),
        _buildDropdown(),
        const SizedBox(height: 24),
        _buildTextFields(),
        const SizedBox(height: 8),
        _buildQuantity(),
      ],
    );
  }

  Widget _buildWarning() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red[700], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Check spelling carefully before placing your order. Your item will be printed exactly as typed and personalised products are not eligible for refunds.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.red[900],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LINES AND LOCATION',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!),
          ),
          child: DropdownButtonFormField<String>(
            initialValue: _config,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: InputBorder.none,
            ),
            items: const [
              DropdownMenuItem(value: '1_front', child: Text('1 line – front')),
              DropdownMenuItem(
                  value: '2_front', child: Text('2 lines – front')),
              DropdownMenuItem(
                  value: '3_front', child: Text('3 lines – front')),
              DropdownMenuItem(value: '1_back', child: Text('1 line – back')),
              DropdownMenuItem(value: '2_back', child: Text('2 lines – back')),
              DropdownMenuItem(value: '3_back', child: Text('3 lines – back')),
              DropdownMenuItem(
                  value: '1_both', child: Text('1 line – front & back')),
              DropdownMenuItem(
                  value: '2_both', child: Text('2 lines – front & back')),
              DropdownMenuItem(
                  value: '3_both', child: Text('3 lines – front & back')),
            ],
            onChanged: (value) => setState(() => _config = value ?? _config),
          ),
        ),
      ],
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: [
        for (var i = 0; i < _lineCount; i++) ...[
          if (i > 0) const SizedBox(height: 16),
          Text(
            'LINE ${i + 1} (MAX 10 CHARACTERS)',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: TextField(
              controller: _controllers[i],
              maxLength: 10,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildQuantity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUANTITY',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildQuantityButton(
                icon: Icons.remove,
                onTap: _quantity > 1 ? () => setState(() => _quantity--) : null,
                enabled: _quantity > 1,
              ),
              Container(
                width: 60,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                child: Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _buildQuantityButton(
                icon: Icons.add,
                onTap: () => setState(() => _quantity++),
                enabled: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback? onTap,
    required bool enabled,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          child: Icon(icon,
              size: 18, color: enabled ? Colors.black : Colors.grey[400]),
        ),
      ),
    );
  }
}
