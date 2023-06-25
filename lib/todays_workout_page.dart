import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wegojim/components/date_converter.dart';
import 'package:wegojim/components/saved_workout.dart';

class TodaysWorkout extends StatelessWidget {
  final useremail = FirebaseAuth.instance.currentUser?.email;
  DateTime today = DateTime.now();

  TodaysWorkout({super.key});

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
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
      ),
      body: StreamBuilder<List<SavedWorkout>>(
          stream: readData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              final listWorkouts = snapshot.data!;
              if (listWorkouts.isEmpty) {
                return Text('No Workouts Planned!');
              } else {
                return ListView(
                  children: listWorkouts.map(eachWorkout).toList(),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
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
          contentPadding: EdgeInsets.all(8.0),
          title: Text(sWorkout.name.toUpperCase(), 
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0
        )),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sets: ${sWorkout.sets}', 
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0
            ),),
          Text(
            'Repetitions: ${sWorkout.repetitions}', 
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0
            ),),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      tileColor: Colors.grey.shade800,
    ),
  );
}
