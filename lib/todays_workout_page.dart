import 'package:flutter/material.dart';

class TodaysWorkout extends StatelessWidget {
  const TodaysWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      appBar: AppBar(
        title: const Text('Today\'s Workout', style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,)
        ),
      ),
    );
  }
}
