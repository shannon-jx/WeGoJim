import 'package:flutter/material.dart';


class UpperBodyPage extends StatelessWidget {
  const UpperBodyPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Upper Body Page'),
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      body: const Center(
        child: Text('Upper Body Content'),
      ),
    );
  }
}