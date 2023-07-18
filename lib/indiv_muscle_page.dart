// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:wegojim/components/workout.dart';
import 'package:wegojim/components/workout_tile.dart';
import 'package:http/http.dart' as http;

class IndivMusclePage extends StatefulWidget {
  final String title;

  const IndivMusclePage({super.key, required this.title});

  @override
  State<IndivMusclePage> createState() => _IndivMusclePageState();
}

class _IndivMusclePageState extends State<IndivMusclePage> {
  final searchController = TextEditingController();
  int selectedIndex = 0;
  String selectedEquipment = '';
  final List equipments = [
    'All',
    'Band',
    'Barbell',
    'Cable',
    'Dumbbells',
    'Kettlebell',
    'Lever',
    'Smith',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(
              left: 25.0,
              right: 25.0,
              top: 15.0,
              bottom: 15.0
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                onChanged: (value) => _filter(value, selectedEquipment),
                controller: searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),

          Container(
            height: 60,
            child: ListView.builder(
              itemCount: 8,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      String equipment = equipments[index].toString().toLowerCase();
                      String keyword = searchController.text;
                      if (equipment == 'all') {
                        equipment = '';
                      }
                      _filter(keyword, equipment);
                      setState(() {
                        selectedIndex = index;
                        selectedEquipment = equipment;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        shape: BoxShape.rectangle,
                        color: (selectedIndex == index) ? Colors.red : Colors.white
                      ),
                      child: Center(child: Text(equipments[index])),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(child: _PaginatedFirestoreList(title: widget.title)),
        ],
      ),
    );
  }

  void _filter(String keyword, String equipment) {
    setState(() {
      _PaginatedFirestoreList.keywords = keyword.toLowerCase();
      _PaginatedFirestoreList.selectedEquipment = equipment.toLowerCase();
    });
  }
}

class _PaginatedFirestoreList extends StatelessWidget {
  final String title;
  static String keywords = '';
  static String selectedEquipment = '';

  const _PaginatedFirestoreList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      query: FirebaseFirestore.instance.collection('data-${title.toLowerCase()}'),
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
