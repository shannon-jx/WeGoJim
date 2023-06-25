// ignore_for_file: sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wegojim/components/date_converter.dart';
import 'package:wegojim/components/my_button.dart';
import 'package:wegojim/components/saved_workout.dart';

// ignore: must_be_immutable
class EditWorkoutDialog extends StatefulWidget {
  final SavedWorkout sWorkout;
  DateTime setDate;
  TextEditingController nameController;
  double sliderValue;
  int selectedIndex;
  final FixedExtentScrollController scrollController;

  EditWorkoutDialog({
    super.key,
    required this.sWorkout, 
    required this.setDate,
    required this.nameController,
    required this.sliderValue,
    required this.selectedIndex,
    required this.scrollController
  });

  @override
  State<EditWorkoutDialog> createState() => _EditWorkoutDialogState();
}

class _EditWorkoutDialogState extends State<EditWorkoutDialog> {
  final useremail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {

    Future<void> updateData() async {
      await FirebaseFirestore.instance.collection(useremail!).doc(widget.sWorkout.id).update({
        'Name': widget.nameController.text.trim(),
        'Date': DateConverter.convert(widget.setDate),
        'Sets': widget.sliderValue,
        'Repetitions': widget.selectedIndex,
      });
    }

    return AlertDialog(
      elevation: 10.0,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Edit Workout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0
            ),
          ),
          IconButton(
            icon: const Icon(Icons.cancel, size: 25.0,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),        
        ],
      ),
      content: Container(
        height: 400.0,
        child: Column(
          children: [
            TextField(
              controller: widget.nameController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
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
                        widget.setDate = value!;
                      });
                    });
                  },
                  child: Text(
                    '${widget.setDate.day}/${widget.setDate.month}/${widget.setDate.year}',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                )
              ],
            ),
            
            Row(
              children: [
                const Text('Sets: ', style: TextStyle(fontSize: 20.0)),
                Expanded(
                  child: Column(
                    children: [
                      Text(widget.sliderValue.toInt().toString(),
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      Slider(
                          value: widget.sliderValue,
                          min: 1,
                          max: 10,
                          divisions: 9,
                          onChanged: (value) {
                            setState(() {
                              widget.sliderValue = value;
                            });
                          })
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Repetitions: ', style: TextStyle(fontSize: 20.0))),
            Container(
              width: 450.0,
              height: 100.0,
              child: RotatedBox(
                quarterTurns: -1,
                child: Center(
                  child: ListWheelScrollView(
                    controller: widget.scrollController,
                    itemExtent: 50,
                    perspective: 0.005,
                    diameterRatio: 1.8,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (newIndex) {
                      setState(() {
                        widget.selectedIndex = newIndex;
                      });
                    },
                    children: List.generate(
                      31,
                      (index) => RotatedBox(
                        quarterTurns: 1,
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            width: index == widget.selectedIndex ? 60 : 50,
                            height: index == widget.selectedIndex ? 60 : 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: index == widget.selectedIndex
                                  ? Colors.red
                                  : Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$index',
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
      
            MyButton(
              onTap: () {
                updateData();
                Navigator.pop(context);
              }, 
              desc: 'SAVE CHANGES'
            )
          ],
        ),
      ),
    );
  }
}
