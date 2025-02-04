import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color.fromRGBO(96, 81, 81, 1.0),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: const [
          NotificationItem(
            title: 'New Product Alert!',
            message: 'Check out our latest crochet creations!',
            time: '10:00 AM',
          ),
          NotificationItem(

            title: 'Special Offer',
            message: 'Get 20% off on all yarn today!',
            time: 'Yesterday',
          ),
          NotificationItem(
            title: 'Order Update',
            message: 'Your order #12345 has been shipped.',time: '2 days ago',
          ),
          // Add more NotificationItem widgets here
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String time;

  const NotificationItem({
    super.key,
    required this.title,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.notifications_active, color: Color.fromRGBO(96, 81, 81, 1.0),),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            Text(
              time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),),
          ],
        ),
      ),
    );
  }
}