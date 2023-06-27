import 'package:flutter/material.dart';
import 'package:wegojim/components/my_bottom_sheet.dart';
import 'package:wegojim/components/my_button.dart';
import 'package:wegojim/components/workout.dart';

class DetailedWorkout extends StatefulWidget {
  final Workout workout;

  const DetailedWorkout({super.key, required this.workout});

  @override
  State<DetailedWorkout> createState() => _DetailedWorkoutState();
}

class _DetailedWorkoutState extends State<DetailedWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.name.toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(
                  widget.workout.image
                )
              ),
      
              const SizedBox(height: 15.0,),
        
              Text(
                widget.workout.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold
                ),
              ), 
      
              const SizedBox(height: 15.0,),
        
              Text(
                'Difficulty: ${widget.workout.difficulty.toUpperCase()}\nEquipment: ${widget.workout.equipment.toUpperCase()}\nBody Part: ${widget.workout.bodyPart.toUpperCase()}\nTarget: ${widget.workout.target.toUpperCase()}\nInstructions: \n${widget.workout.instructions.toUpperCase()}',
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ), 
      
              const SizedBox(height: 20.0,),
      
              MyButton(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return MyBottomSheet(workout: widget.workout);
                      },
                    );
                  },
                  desc: 'ADD TO CALENDAR'
              )
            ],
          ),
        ),
      ),
    );
  }
}