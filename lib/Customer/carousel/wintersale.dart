import 'package:flutter/material.dart';

class WinterSale extends StatelessWidget {
  const WinterSale({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Winter Sale')),
      body: const Center(child: Text('Sale coming soon')),
    );
  }
}
