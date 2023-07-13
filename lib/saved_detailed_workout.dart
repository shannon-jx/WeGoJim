// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:wegojim/components/my_bottom_sheet.dart';
import 'package:wegojim/components/my_button.dart';
import 'package:wegojim/components/saved_workout.dart';
import 'package:wegojim/components/workout.dart';

class SavedDetailedWorkout extends StatefulWidget {
  final SavedWorkout workout;

  SavedDetailedWorkout({super.key, required this.workout});

  @override
  State<SavedDetailedWorkout> createState() => _SavedDetailedWorkoutState();
}

class _SavedDetailedWorkoutState extends State<SavedDetailedWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.workout.name.toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Icon(
                Icons.fitness_center,
                size: 40,
                color: Colors.white,
              ),
      
              SizedBox(height: 15.0,),
        
              Text(
                widget.workout.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ), 
      
              SizedBox(height: 15.0,),
        
              Text(
                'Difficulty: ${widget.workout.difficulty.toUpperCase()}\nEquipment: ${widget.workout.equipment.toUpperCase()}\nBody Part: ${widget.workout.bodyPart.toUpperCase()}\nTarget: ${widget.workout.target.toUpperCase()}\nInstructions: \n${widget.workout.instructions.toUpperCase()}',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white
                ),
              ), 
      
              SizedBox(height: 20.0,),
      
              MyButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  desc: 'BACK'
              )
            ],
          ),
        ),
      ),
    );
  }
}