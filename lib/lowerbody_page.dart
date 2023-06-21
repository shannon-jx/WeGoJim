import 'package:flutter/material.dart';

class LowerBodyPage extends StatelessWidget {
  const LowerBodyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lower Body Page'),
      ),
      body: const Center(
        child: Text('Lower Body Content'),
      ),
    );
  }
}