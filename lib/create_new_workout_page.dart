/* import 'package:flutter/material.dart';

class CreateNewWorkout extends StatefulWidget {
  const CreateNewWorkout({super.key});

  @override
  State<CreateNewWorkout> createState() => _CreateNewWorkoutState();
}

class _CreateNewWorkoutState extends State<CreateNewWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        title: const Text('Create New Workout', style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,)
        ),
      ),
      body: Column(
        children: [
          Image.network('https://wallpapers.com/images/hd/attractive-man-weight-lifting-7i9jt93nxllz9aet.jpg')
        ],
      ),
    );
  }
} */


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
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text(''),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            
            SizedBox(height: 50.0),
      
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
                      MuscleTile(muscle: "Forearms", imageLink: "https://cdn.3d4medical.com/media/blog/forearm-compartments/arm2.jpg",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Triceps", imageLink: "https://st2.depositphotos.com/1047356/8599/i/950/depositphotos_85998648-stock-photo-triceps-human-anatomy.jpg",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Traps", imageLink: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgOSxHnq0tP3CHBVBNa0wWSTuSHY8-CHUo-A&usqp=CAU",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Chest", imageLink: "https://cdn.3d4medical.com/media/blog/forearm-compartments/arm2.jpg",),
                    ],
                  ),
                  Column(
                    children: [
                      MuscleTile(muscle: "Biceps", imageLink: "https://media.istockphoto.com/id/1217690975/photo/biceps-brachii-muscles-isolated-anterior-view-anatomy-on-black-background.jpg?s=1024x1024&w=is&k=20&c=7REkNtzgXnB8LTMUeqANMjhE5as5vEmO7EDEdjvqdQI=",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Shoulders", imageLink: "https://c8.alamy.com/comp/2A14CF0/labeled-anatomy-chart-of-neck-and-shoulder-muscles-on-black-background-2A14CF0.jpg",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Back", imageLink: "https://st.focusedcollection.com/13422768/i/650/focused_312138832-stock-photo-female-anatomy-showing-back-muscles.jpg",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Abs", imageLink: "https://cdn.3d4medical.com/media/blog/forearm-compartments/arm2.jpg",),
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
                      MuscleTile(muscle: "Glutes", imageLink: "https://cdn.3d4medical.com/media/blog/forearm-compartments/arm2.jpg",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Hamstrings", imageLink: "https://cdn.3d4medical.com/media/blog/forearm-compartments/arm2.jpg",),
                      SizedBox(height: 20),
                    ],
                  ),
                  Column(
                    children: [
                      MuscleTile(muscle: "Quads", imageLink: "https://cdn.3d4medical.com/media/blog/forearm-compartments/arm2.jpg",),
                      SizedBox(height: 20),
                      MuscleTile(muscle: "Calves", imageLink: "https://cdn.3d4medical.com/media/blog/forearm-compartments/arm2.jpg",),
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
