import 'package:flutter/material.dart';

class ReturnRefundPolicyScreen extends StatelessWidget {
  const ReturnRefundPolicyScreen({Key?key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        title: const Text('Return & Refund Policy'),
        backgroundColor: const Color.fromRGBO(96, 81, 81, 1.0),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Regarding our Return & Refund Policy',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,color: const Color(0xFFEC407A),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const PolicyItem(
                text:
                '1. Return Eligibility: Items can be returned only when there is a defect on the product and it must be checked infront of the delivery man.',
              ),
              const SizedBox(height: 16),
              const PolicyItem(
                text:
                '2. Non-Returnable Items: Customized products, are not eligible for returns unless it is ruined. Because customizable products are only made for a certain person only.',
              ),
              const SizedBox(height: 16),

              const PolicyItem(
                text:
                '3. Shipping Costs: Customers are responsible for return shipping costs unless the return is due to a defective or incorrect item.',
              ),
              const SizedBox(height: 16),
              const PolicyItem(
                text:'4. Damaged or Incorrect Items: If you receive a damaged or incorrect item, contact our support team within 48 hours for assistance.',
              ),
              const SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }
}

class PolicyItem extends StatelessWidget {
  final String text;

  const PolicyItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: const Color(0xFF4A148C),
        height: 1.5,
      ),
    );
  }
}