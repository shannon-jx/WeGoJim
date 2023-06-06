import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPWPage extends StatefulWidget {
  const ForgotPWPage({super.key});

  @override
  State<ForgotPWPage> createState() => _ForgotPWPageState();
}

class _ForgotPWPageState extends State<ForgotPWPage> {
  final _emailController = TextEditingController();

  Future resetPW() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim());
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
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: _emailController,
          ),

          MaterialButton(
            onPressed: resetPW,
            child: const Text('Reset Password'),
          )
        ],
      ),
    );
  }
}