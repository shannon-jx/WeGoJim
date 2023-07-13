import 'package:flutter/material.dart';
import 'package:wegojim/detailed_workout.dart';
import 'package:wegojim/components/my_bottom_sheet.dart';
import 'package:wegojim/components/workout.dart';

// ignore: must_be_immutable
class WorkoutTile extends StatefulWidget {
  Workout workout;

  WorkoutTile({super.key, required this.workout});

  @override
  State<WorkoutTile> createState() => _WorkoutTileState();
}

class _WorkoutTileState extends State<WorkoutTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailedWorkout(workout: widget.workout)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.workout.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            softWrap: true,
                          ),
                          SizedBox(
                            height: 200.0,
                            width: 200.0,
                            child: Image(
                              image: NetworkImage(widget.workout.image),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Text(
                        'EQUIPMENT: ${widget.workout.equipment.toUpperCase()}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 22.0,
                          backgroundColor: Colors.transparent,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 65.0,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: Colors.red,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Icon(Icons.add),
                      ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return MyBottomSheet(workout: widget.workout);
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
