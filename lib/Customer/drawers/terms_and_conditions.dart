import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
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
                  'Terms & Conditions of our Store',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color:const Color(0xFFEC407A),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const PolicyItem(
                text:
                '1. Acceptance of Terms: By accessing and using this app, you agree to be bound by these Terms & Conditions.',
              ),
              const SizedBox(height: 16),
              const PolicyItem(
                text:
                '2. User Responsibilities: You are responsible for keeping your account secure and ensuring that your activities comply with our policies.',
              ),
              const SizedBox(height: 16),
              const PolicyItem(
                text:
                '3. Prohibited Activities: Users must not engage in illegal activities, abuse the platform, or violate any applicable laws.',
              ),
              const SizedBox(height: 16),
              const PolicyItem(
                text:
                '4. Content Ownership: Any content you upload remains your property, but by posting, you grant us a license to use it.',
              ),
              const SizedBox(height: 16),
              const PolicyItem(
                text:
                '5. Limitation of Liability: We are not liable for any damages resulting from the use of this app.',
              ),
              const SizedBox(height: 16),
              const PolicyItem(
                text:
                '6. Modifications: We reserve the right to modify these terms at any time. Continued use of the app implies acceptance of the updated terms.',
              ),
              const SizedBox(height: 16),
              const PolicyItem(
                text:
                '7. Termination: We may suspend or terminate your account if you violate these Terms & Conditions.',
              ),
              const SizedBox(height: 16),
              const PolicyItem(
                text:
                '8. Contact Information: If you have any questions, you can contact us at crochetoclock@gmail.com.',
              ),
              const SizedBox(height: 20),
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

