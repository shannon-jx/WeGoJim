import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:wegojim/components/workout.dart';
import 'package:wegojim/components/workout_tile.dart';

class PaginatedFirestoreList extends StatelessWidget {
  final String title;
  static String keywords = '';
  static String selectedEquipment = '';
  final FirebaseFirestore firestore; 

  const PaginatedFirestoreList({super.key, required this.title, required this.firestore});

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      query: firestore.collection('data-${title.toLowerCase()}'),
      itemBuilderType: PaginateBuilderType.listView,
      itemsPerPage: 5,
      initialLoader: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      onEmpty: const Center(
        child: Text('Empty data!'),
      ),
      onError: (e) => const Center(
        child: CircularProgressIndicator(),
      ),
      bottomLoader: const Center(
        child: CircularProgressIndicator(),
      ),
      itemBuilder: (context, snapshot, index) {
        final Map<String, dynamic> json =
            snapshot[index].data() as Map<String, dynamic>;

        final workout = Workout(
            name: json['Name'],
            difficulty: json['Difficulty'],
            equipment: json['Equipment'],
            image: json['Image'],
            instructions: json['Instructions'],
            bodyPart: json['Body Part'],
            target: json['Target']);

        if (workout.name.toLowerCase().contains(keywords.toLowerCase()) 
          && (selectedEquipment.isEmpty 
            || workout.equipment.toLowerCase().contains(selectedEquipment))) {
          return WorkoutTile(workout: workout);
        } else {
          return Container();
        }
      },
    );
  }
}