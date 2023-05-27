import 'package:flutter/material.dart';

class TodaysWorkout extends StatelessWidget {
  const TodaysWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today\'s Workout'),
      ),
      body: const Center(
        child: Text(
          'Today\'s Workout Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
