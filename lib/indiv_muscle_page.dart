import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wegojim/components/workout.dart';
import 'package:wegojim/components/workout_tile.dart';
import 'package:http/http.dart' as http;

class IndivMusclePage extends StatefulWidget {
  final String title;

  IndivMusclePage({super.key, required this.title});

  @override
  State<IndivMusclePage> createState() => _IndivMusclePageState();
}

class _IndivMusclePageState extends State<IndivMusclePage> {
  List<Workout> foundWorkouts = [];
  List<Workout> workouts = [];
  final searchController = TextEditingController();

  Future getWorkouts() async {
    final link = (widget.title == 'Chest' || widget.title == 'Back' || widget.title == 'Shoulders') 
      ? 'https://exercisedb.p.rapidapi.com/exercises/bodyPart/${widget.title.toLowerCase()}'
      : 'https://exercisedb.p.rapidapi.com/exercises/target/${widget.title.toLowerCase()}';
    final response = await http.get(
      Uri.parse(link),
      headers: {
        'X-RapidAPI-Key': '60f6a7afb6msh6c3f568740f6e4cp188d55jsn3b283e518391',
        'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
      }
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      for (var eachW in jsonData) {
        var response2 = await http.get(
          Uri.https('api.api-ninjas.com','/v1/exercises', {'name': eachW['name'].toString().toLowerCase()}),
          headers: {'X-Api-Key': 'gXmuQQlTEDgRdp1ErLWFWA==ypBE15MSBgboTq3I'}
        );
        var jsonData2 = jsonDecode(response2.body) as List;

        final workout = Workout(
          name: eachW['name'], 
          difficulty: (jsonData2.length == 0) ? 'not indicated' : jsonData2[0]['difficulty'],
          equipment: eachW['equipment'],  
          image: eachW['gifUrl'], 
          instructions: eachW['gifUrl'], 
        );
        workouts.add(workout);
      }
      print(workouts.length);
    } else {
      print('Failed');
    }
  }

  @override
  void initState() {
    foundWorkouts = workouts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
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
                  onChanged: (value) => _filter(value),
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

            FutureBuilder(
              future: getWorkouts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SafeArea(
                    child: SizedBox(
                      height: 670.0,
                      child: ListView.builder(
                        itemCount: foundWorkouts.length,
                        itemBuilder: (context, index) {
                          return WorkoutTile(
                            workout: foundWorkouts[index]
                          );
                        }
                      ),
                    ),
                  );
                }
                else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }

  void _filter(String keyword) {
    List<Workout> results = [];
    if (keyword.isEmpty) {
      results = workouts;
    } else {
      results = workouts
          .where((item) =>
              item.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundWorkouts = results;
    });
  }
}