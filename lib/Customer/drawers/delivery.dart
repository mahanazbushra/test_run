import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Delivery extends StatelessWidget {const Delivery({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  return Scaffold( // Changed from MaterialApp to Scaffold
    body: const DeliveryPolicyScreen(),
  );
}
}

class DeliveryPolicyScreen extends StatelessWidget {const DeliveryPolicyScreen({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
    value: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Delivery Policy'),
        backgroundColor: const Color.fromRGBO(96, 81, 81, 1.0),
        foregroundColor: Colors.white,

        elevation: 0,centerTitle: true,
        automaticallyImplyLeading: true, // This is already true by default
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
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
                  'Regarding our Delivery Policies',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,

                    color: const Color(0xFFEC407A),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const PolicyItem(
                text:
                '1. Processing Time: Orders are processed within 1-2 business days after payment confirmation.',
              ),
              const SizedBox(height: 16),
              const PolicyItem(
                text:
                '2. Delivery Time: Depending on the region, delivery times vary from 3 to 7 business days.',),
              const SizedBox(height: 16),
              const PolicyItem(
                text:
                '3. Delivery Charge: Shipping fees are calculated based on the destination and package weight.',
              ),
              const SizedBox(height: 16),
              const PolicyItem(
                text:
                '4. Tracking Orders: Customers will receive a tracking number via email after their order has been shipped.',
              ),
              const SizedBox(height: 16),
              const PolicyItem(
                text:
                '5. Delays & Issues: We are not responsible for delays caused by external factors such as weather, customs, or carrier issues.',
              ),
              const SizedBox(height: 32),
            ],
          ),
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
        color: const Color(0xFF880E4F),
        height: 1.5,
      ),
    );
  }
}

