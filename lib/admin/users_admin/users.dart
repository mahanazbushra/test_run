import 'package:flutter/material.dart';

class UsersAdmin extends StatelessWidget {
  const UsersAdmin({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users List')),
      body: const Center(
        child: Text('This is the User page!'),
      ),
    );
  }
}