import 'package:flutter/material.dart';
import 'package:union_shop/widgets/header.dart';
import 'package:union_shop/widgets/footer.dart';

class PrintShackPage extends StatefulWidget {
  const PrintShackPage({super.key});

  @override
  State<PrintShackPage> createState() => _PrintShackPageState();
}

class _PrintShackPageState extends State<PrintShackPage> {
  final String _config = '1_front';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(),
            Container(),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
