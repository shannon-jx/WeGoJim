import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  bool _isEditing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
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
            TextField(
              controller: _nameController,
              enabled: _isEditing,
              style: const TextStyle(color: Colors.white), 
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white), 
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), 
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              enabled: _isEditing,
              style: const TextStyle(color: Colors.white), 
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white), 
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), 
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _heightController,
              enabled: _isEditing,
              style: const TextStyle(color: Colors.white), 
              decoration: const InputDecoration(
                labelText: 'Height',
                labelStyle: TextStyle(color: Colors.white), 
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), 
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _weightController,
              enabled: _isEditing,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Weight',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), 
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  foregroundColor: _isEditing ? Colors.red : Colors.red, backgroundColor: _isEditing ? Colors.transparent : Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: _isEditing ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
                child: Text(
                  _isEditing ? 'Done Editing' : 'Edit Profile',
                  style: TextStyle(
                    color: _isEditing ? Colors.red : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}