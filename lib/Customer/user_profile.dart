import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_run/Customer/widget/text_box.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromRGBO(253, 227, 227, 1.0),
        title: Text(
          "Edit $field",
          style: TextStyle(
            color: Color.fromRGBO(96, 81, 81, 1.0),
          ),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.brown),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Color.fromRGBO(96, 81, 81, 1.0),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: Text(
              'Save',
              style: TextStyle(
                color: Color.fromRGBO(96, 81, 81, 1.0),
              ),
            ),
          ),
        ],
      ),
    ).then((value) async {
      if (value != null && value.isNotEmpty) {
        await _firestore.collection("users").doc(currentUser.email).update({
          field: value,
        });

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 227, 227, 1.0),
      appBar: AppBar(
        title: Text("User Profile"),
        backgroundColor: const Color.fromRGBO(96, 81, 81, 1.0),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream:
            _firestore.collection("users").doc(currentUser.email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text(
                "No user data found.",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return ListView(
            children: [
              const SizedBox(height: 50),
              Icon(
                Icons.person,
                size: 72,
              ),
              const SizedBox(height: 50),
              Text(
                currentUser.email!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(96, 81, 81, 1.0),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  'About the User',
                  style: TextStyle(
                    color: Color.fromRGBO(96, 81, 81, 1.0),
                  ),
                ),
              ),
              MyTextBox(
                text: userData['name'] ?? 'No name',
                sectionName: 'Name',
                onPressed: () => editField('name'),
              ),
              MyTextBox(
                text: userData['address'] ?? 'No address',
                sectionName: 'Address',
                onPressed: () => editField('address'),
              ),
              MyTextBox(
                text: userData['phone'] ?? 'No Phone Number',
                sectionName: 'Phone Number',
                onPressed: () => editField('phone'),
              ),
            ],
          );
        },
      ),
    );
  }
}
