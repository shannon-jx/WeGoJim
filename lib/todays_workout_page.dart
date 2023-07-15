// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wegojim/components/date_converter.dart';
import 'package:wegojim/components/saved_workout.dart';
import 'package:wegojim/saved_detailed_workout.dart';

// ignore: must_be_immutable
class TodaysWorkout extends StatelessWidget {
  final useremail = FirebaseAuth.instance.currentUser?.email;
  DateTime today = DateTime.now();

  TodaysWorkout({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Today\'s Workout',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<List<SavedWorkout>>(
        stream: readData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            final listWorkouts = snapshot.data!;
            if (listWorkouts.isEmpty) {
              return const Text('No Workouts Planned!');
            } else {
              return ListView.builder(
                itemCount: listWorkouts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Stay on track with your fitness goals! \nUnsure how to perform the exercise? Click on the workout for more information.',
                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                    );
                  } else {
                    final sWorkout = listWorkouts[index - 1];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SavedDetailedWorkout(workout: sWorkout),
                          ),
                        );
                      },
                      child: eachWorkout(sWorkout),
                    );
                  }
                },
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stream<List<SavedWorkout>> readData() => FirebaseFirestore.instance
      .collection(useremail!)
      .where('Date', isEqualTo: DateConverter.convert(today))
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => SavedWorkout.fromJson(doc.data()))
          .toList());

  Widget eachWorkout(SavedWorkout sWorkout) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          title: Text(
            sWorkout.name.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sets: ${sWorkout.sets}',
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              Text(
                'Repetitions: ${sWorkout.repetitions}',
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: const BorderSide(color: Colors.red, width: 2),
          ),
          tileColor: Colors.grey[900],
        ),
      );
}
