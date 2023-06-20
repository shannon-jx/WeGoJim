import 'package:flutter/material.dart';
import 'package:wegojim/components/workout.dart';

// ignore: must_be_immutable
class WorkoutTile extends StatelessWidget {
  Workout workout;

  WorkoutTile({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                          workout.name,
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
                            image: NetworkImage(workout.image),
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
                Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: Text(
                    workout.difficulty,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 22.0,
                      backgroundColor: Colors.transparent,
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
                        return Container(
                          height: 600.0,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            color: Colors.grey.shade300,
                          ),
                          child: Container(
                            child: const Column(
                              children: [
                                SizedBox(height: 40.0),
                                Text(
                                  'Add this Workout',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}