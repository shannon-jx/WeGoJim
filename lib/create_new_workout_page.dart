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
import 'package:wegojim/workout%20pages/lowerbody_page.dart';
import 'package:wegojim/workout%20pages/upperbody_page.dart';
class CreateNewWorkout extends StatefulWidget {
  const CreateNewWorkout({super.key});

  @override
  State<CreateNewWorkout> createState() => _CreateNewWorkoutState();
}

class _CreateNewWorkoutState extends State<CreateNewWorkout> {
  bool isUpperBodySelected = false;
  bool isLowerBodySelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Muscle Group Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpperBodyPage(),
                  ),
                );
              },
              child: MouseRegion(
                onEnter: (_) {
                  setState(() {
                    isUpperBodySelected = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    isUpperBodySelected = false;
                  });
                },
                child: Container(
                  width: 200,
                  height: 300,
                  color: isUpperBodySelected ? Colors.red : Colors.grey,
                  child: const Center(
                    child: Text(
                      'Upper Body',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LowerBodyPage(),
                  ),
                );
              },
              child: MouseRegion(
                onEnter: (_) {
                  setState(() {
                    isLowerBodySelected = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    isLowerBodySelected = false;
                  });
                },
                child: Container(
                  width: 200,
                  height: 300,
                  color: isLowerBodySelected ? Colors.red : Colors.grey,
                  child: const Center(
                    child: Text(
                      'Lower Body',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
