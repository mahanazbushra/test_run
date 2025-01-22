import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order List')),
      body: const Center(
        child: Text('This is the Order List page!'),
      ),
    );
  }
}