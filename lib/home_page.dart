import 'package:flutter/material.dart';
import 'package:wegojim/create_new_workout_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: Colors.red,
          ),
          height: 250,
          padding: const EdgeInsets.only(
            left: 30,
            bottom: 40,
          ),
          child: const Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Welcome Back, Shannon.',
              style: TextStyle(
                fontSize: 43,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const CreateNewWorkout();
                },
              ),
            );
          },
        child: const Text('+ Create New Workout', style: TextStyle(color: Colors.black),),
        ),
      ],
    );
  }
}
