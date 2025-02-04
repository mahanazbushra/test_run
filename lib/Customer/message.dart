
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 227, 227,1.0),
      appBar: AppBar(
        title: Text("Chat with seller"),
        backgroundColor: const Color.fromRGBO(96, 81, 81, 1.0),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          "Chat Feature Coming Soon!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600], // Customize the text color
          ),
        ),
      ),
    );
  }
}