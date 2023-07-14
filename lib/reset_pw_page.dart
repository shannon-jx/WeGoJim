import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPWPage extends StatefulWidget {
  const ResetPWPage({super.key});

  @override
  State<ResetPWPage> createState() => _ResetPWPageState();
}

class _ResetPWPageState extends State<ResetPWPage> {
  final _emailController = TextEditingController();

  Future resetPW() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      popUp('Password reset link sent! Check your email');
    } on FirebaseAuthException catch (e) {
      popUp(e.message.toString());
    }
  }

  void popUp(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.black],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.key,
              size: 100,
              color: Colors.white,
            ),
            const Text(
              'New Password?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Registered Email',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            MaterialButton(
              onPressed: resetPW,
              child: Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Reset Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
