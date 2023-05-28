import 'package:flutter/material.dart';

class CreateNewWorkout extends StatefulWidget {
  const CreateNewWorkout({super.key});

  @override
  State<CreateNewWorkout> createState() => _CreateNewWorkoutState();
}

class _CreateNewWorkoutState extends State<CreateNewWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        title: const Text('Create New Workout', style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,)
        ),
      ),
      body: Column(
        children: [
          Image.network('https://wallpapers.com/images/hd/attractive-man-weight-lifting-7i9jt93nxllz9aet.jpg')
        ],
      ),
    );
  }
}