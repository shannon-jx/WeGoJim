import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final useremail = FirebaseAuth.instance.currentUser?.email;

  bool _isEditing = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(useremail!)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;
        _nameController.text = userData['Name'];
        _emailController.text = userData['Email'];
        _heightController.text = userData['Height'];
        _weightController.text = userData['Weight'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.red),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_isEditing) {
                _updateData();
              }
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            color: Colors.red,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileInfoTextField(
              label: 'Name',
              controller: _nameController,
              enabled: _isEditing,
            ),
            const SizedBox(height: 16.0),
            ProfileInfoTextField(
              label: 'Email',
              controller: _emailController,
              enabled: _isEditing,
            ),
            const SizedBox(height: 16.0),
            ProfileInfoTextField(
              label: 'Height',
              controller: _heightController,
              enabled: _isEditing,
            ),
            const SizedBox(height: 16.0),
            ProfileInfoTextField(
              label: 'Weight',
              controller: _weightController,
              enabled: _isEditing,
            ),
            const SizedBox(height: 25.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_isEditing) {
                    _updateData();
                  }
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 16),
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: const Text(
                  'Save Edits',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateData() async {
    await FirebaseFirestore.instance.collection('users').doc(useremail).update({
      'Name': _nameController.text.trim(),
      'Email': _emailController.text.trim(),
      'Height': _heightController.text.trim(),
      'Weight': _weightController.text.trim(),
    });
  }
}

class ProfileInfo extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfo({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label + '',
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 10.0),
        Text(value,
            style: const TextStyle(color: Colors.white, fontSize: 16.0)),
      ],
    );
  }
}

class ProfileInfoTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;

  const ProfileInfoTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
