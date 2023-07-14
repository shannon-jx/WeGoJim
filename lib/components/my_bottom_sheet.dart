import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wegojim/components/date_converter.dart';
import 'package:wegojim/components/my_button.dart';
import 'package:wegojim/components/workout.dart';

class MyBottomSheet extends StatefulWidget {
  final Workout workout;

  const MyBottomSheet({super.key, required this.workout});

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  final useremail = FirebaseAuth.instance.currentUser?.email;
  DateTime _setDate = DateTime.now();
  double _sliderValue = 1;
  int selectedIndex = 0;
  final _scrollController = FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Colors.grey.shade300,
      ),
      child: Column(
        children: [
          const SizedBox(height: 20.0),

          const Text(
            'Add this Workout',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15.0,),

          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name: ${widget.workout.name.toUpperCase()}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      const Text('Date: ', style: TextStyle(fontSize: 20.0)),
                      TextButton(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2050))
                              .then((value) {
                            setState(() {
                              _setDate = value!;
                            });
                          });
                        },
                        child: Text(
                          '${_setDate.day}/${_setDate.month}/${_setDate.year}',
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 10.0,),

                  Row(
                    children: [
                      const Text('Sets: ', style: TextStyle(fontSize: 20.0)),
                      Expanded(
                        child: Column(
                          children: [
                            Text(_sliderValue.toInt().toString(),
                                style: const TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.bold)),
                            Slider(
                                value: _sliderValue,
                                min: 1,
                                max: 10,
                                divisions: 9,
                                onChanged: (value) {
                                  setState(() {
                                    _sliderValue = value;
                                  });
                                })
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10.0,),

                  const Align(
                      alignment: Alignment.centerLeft,
                      child:
                          Text('Repetitions: ', style: TextStyle(fontSize: 20.0))),

                  Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: Container(
                      width: 450.0,
                      height: 80.0,
                      child: RotatedBox(
                        quarterTurns: -1,
                        child: Center(
                          child: ListWheelScrollView(
                            controller: _scrollController,
                            itemExtent: 50,
                            perspective: 0.005,
                            diameterRatio: 1.5,
                            physics: const FixedExtentScrollPhysics(),
                            onSelectedItemChanged: (newIndex) {
                              setState(() {
                                selectedIndex = newIndex;
                              });
                            },
                            children: List.generate(
                              30,
                              (index) => RotatedBox(
                                quarterTurns: 1,
                                child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    width: index + 1 == selectedIndex ? 60 : 50,
                                    height: index + 1 == selectedIndex ? 60 : 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: index + 1 == selectedIndex
                                          ? Colors.red
                                          : Colors.grey.shade300,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          MyButton(
            onTap: () {
              addWorkout();
              Navigator.pop(context);
            },
            desc: 'Save to Calendar'
          )
        ],
      ),
    );
  }

  Future addWorkout() async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    final docWorkout = FirebaseFirestore.instance.collection(useremail!).doc(id);

    final json = {
      'id': id,
      'Name': widget.workout.name,
      'Difficulty': widget.workout.difficulty,
      'Equipment': widget.workout.equipment,
      'Image': widget.workout.image,
      'Instructions': widget.workout.instructions,
      'Date': DateConverter.convert(_setDate),
      'Sets' : _sliderValue,
      'Repetitions' : selectedIndex,
      'Body Part': widget.workout.bodyPart,
      'Target': widget.workout.target
    };
    
    await docWorkout.set(json);
  }
}