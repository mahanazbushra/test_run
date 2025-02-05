
import 'package:flutter/material.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 227, 227,1.0),
      appBar: AppBar(
        title: Text("Vouchers and Offers"),
        backgroundColor: const Color.fromRGBO(96, 81, 81, 1.0),
        foregroundColor: Colors.white,
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          "Coming Soon!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}