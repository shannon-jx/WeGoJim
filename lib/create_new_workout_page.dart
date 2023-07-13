import 'package:flutter/material.dart';
import 'package:wegojim/components/muscle_tile.dart';
// ignore: unused_import
import 'package:wegojim/indiv_muscle_page.dart';

class CreateNewWorkout extends StatefulWidget {
  const CreateNewWorkout({super.key});

  @override
  State<CreateNewWorkout> createState() => _CreateNewWorkoutState();
}

class _CreateNewWorkoutState extends State<CreateNewWorkout> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Muscle Group'),
        backgroundColor: Colors.red,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            
            SizedBox(height: 30.0),
      
            Text(
              "UPPER BODY",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              ),
            ),
      
            SizedBox(height: 10.0),
      
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      MuscleTile(muscle: "Forearms", imageLink: "https://st.depositphotos.com/1909187/2819/i/950/depositphotos_28192895-stock-photo-forearms-anatomy-muscles.jpg",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Triceps", imageLink: "https://st.depositphotos.com/1909187/2819/i/950/depositphotos_28192885-stock-photo-triceps-anatomy-muscles.jpg",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Traps", imageLink: "https://st.depositphotos.com/1909187/2819/i/950/depositphotos_28192949-stock-photo-trapezius-anatomy-muscles.jpg",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Chest", imageLink: "https://st.depositphotos.com/1909187/2819/i/950/depositphotos_28192943-stock-photo-chest-pectoralis-major-pectoralis-minor.jpg",),

                    ],
                  ),
                  Column(
                    children: [
                      MuscleTile(muscle: "Biceps", imageLink: "https://st.depositphotos.com/1909187/2819/i/950/depositphotos_28192899-stock-photo-biceps-anatomy-muscles.jpg",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Shoulders", imageLink: "https://st.depositphotos.com/1909187/2819/i/950/depositphotos_28192973-stock-photo-shoulders-anatomy-muscles.jpg",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Back", imageLink: "https://st.depositphotos.com/1909187/2819/i/950/depositphotos_28193021-stock-photo-latissimus-dorsi-anatomy-muscles.jpg",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Abs", imageLink: "https://st.depositphotos.com/1909187/2819/i/950/depositphotos_28192889-stock-photo-abs-anatomy-muscles.jpg",),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 50.0),
      
            Text(
              "LOWER BODY",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              ),
            ),

            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      MuscleTile(muscle: "Glutes", imageLink: "https://st.depositphotos.com/1909187/2819/i/950/depositphotos_28192997-stock-photo-glutes-gluteus-maximus-anatomy-muscles.jpg",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Hamstrings", imageLink: "https://st.depositphotos.com/1909187/2819/i/950/depositphotos_28193019-stock-photo-hamstrings-anatomy-muscles.jpg",),
                      SizedBox(height: 20),
                    ],
                  ),
                  Column(
                    children: [
                      MuscleTile(muscle: "Quads", imageLink: "https://st.depositphotos.com/1265046/1492/i/950/depositphotos_14927583-stock-photo-sporstman-stressed-leg-muscle-quadriceps.jpg",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Calves", imageLink: "https://st.depositphotos.com/1909187/2819/i/950/depositphotos_28193027-stock-photo-calves-anatomy-muscles.jpg",),
                      SizedBox(height: 20),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
