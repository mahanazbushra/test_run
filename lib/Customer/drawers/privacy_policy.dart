import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
                child: const Text(
                  'About Privacy Policy',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF4A148C)),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '1. Introduction: We respect your privacy and are committed to protecting your personal data.',
                style: TextStyle(fontSize: 16, color: Color(0xFF4A148C)),
              ),
              const SizedBox(height: 10),
              const Text(
                '2. Information We Collect: We collect information you provide when using our services, including name, email, and usage data.',
                style: TextStyle(fontSize: 16, color: Color(0xFF4A148C)),
              ),
              const SizedBox(height: 10),
              const Text(
                '3. How We Use Your Information: We use collected data to improve our services, process transactions, and send important updates.',
                style: TextStyle(fontSize: 16, color: Color(0xFF4A148C)),
              ),
              const SizedBox(height: 10),
              const Text(
                '4. Data Protection: We take security measures to protect your data from unauthorized access or disclosure.',
                style: TextStyle(fontSize: 16, color: Color(0xFF4A148C)),
              ),
              const SizedBox(height: 10),
              const Text(
                '5. Sharing Your Information: We do not sell your personal data. However, we may share it with third parties for essential services like payment processing.',
                style: TextStyle(fontSize: 16, color: Color(0xFF4A148C)),
              ),
              const SizedBox(height: 10),
              const Text(
                '6. Cookies and Tracking Technologies: We use cookies to enhance your experience and analyze website traffic.',
                style: TextStyle(fontSize: 16, color: Color(0xFF4A148C)),
              ),
              const SizedBox(height: 10),
              const Text(
                '7. Your Rights: You have the right to access, update, or delete your personal data. Contact us for any requests.',
                style: TextStyle(fontSize: 16, color: Color(0xFF4A148C)),
              ),
              const SizedBox(height: 10),
              const Text(
                '8. Changes to This Policy: We may update this policy. Continued use of our services means acceptance of the changes.',
                style: TextStyle(fontSize: 16, color: Color(0xFF4A148C)),
              ),
              const SizedBox(height: 10),
              const Text(
                '9. Contact Us: If you have any questions about this Privacy Policy, please contact us at crochetoclock@gmail.com.',
                style: TextStyle(fontSize: 16, color: Color(0xFF4A148C)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}