import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wegojim/components/date_converter.dart';
import 'package:wegojim/components/edit_workout_dialog.dart';
import 'package:wegojim/components/saved_workout.dart';
import 'package:wegojim/saved_detailed_workout.dart';

class WorkoutCalendarPage extends StatefulWidget {
  const WorkoutCalendarPage({Key? key}) : super(key: key);

  @override
  State<WorkoutCalendarPage> createState() => _WorkoutCalendarPageState();
}

class _WorkoutCalendarPageState extends State<WorkoutCalendarPage> {
  final useremail = FirebaseAuth.instance.currentUser?.email;
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: content(),
    );
  }

  Widget content() {
    return Container(
      child: Column(
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            child: TableCalendar(
                locale: "en_US",
                headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                        
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                focusedDay: today,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2050, 12, 31),
                onDaySelected: _onDaySelected,
    
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Color.fromARGB(
                        255, 234, 122, 114), 
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  todayTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                  ),
                  weekendTextStyle:
                      TextStyle(color: Color.fromARGB(255, 234, 122, 114), fontWeight: FontWeight.bold, fontSize: 15),
                  outsideDaysVisible: false,
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                  ),
                )),
          ),
    
          const SizedBox(
            height: 20.0,
          ),
    
          Text(
            'Planned Workouts for ${today.day}/${today.month}/${today.year}:',
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
    
          Expanded(
            child: StreamBuilder<List<SavedWorkout>>(
                stream: readData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    final listWorkouts = snapshot.data!;
                    return ListView(
                      children: listWorkouts.map(eachWorkout).toList(),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }

  Stream<List<SavedWorkout>> readData() => FirebaseFirestore.instance
    .collection(useremail!)
    .where('Date', isEqualTo: DateConverter.convert(today))
    .snapshots()
    .map((snapshot) => 
      snapshot.docs.map((doc) => SavedWorkout.fromJson(doc.data())).toList());

  Widget eachWorkout(SavedWorkout sWorkout) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => SavedDetailedWorkout(workout: sWorkout))
        );
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        title: Text(
          sWorkout.name.toUpperCase(), 
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0
          )),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sets: ${sWorkout.sets}', 
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0
              ),),
            Text(
              'Repetitions: ${sWorkout.repetitions}', 
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0
              ),),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: Colors.red, width: 2),
        ),
        tileColor: Colors.grey.shade900,
        trailing: 
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  color: Colors.white,
                  iconSize: 30,
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    editWorkout(sWorkout);
                  },
                ),
                IconButton(
                  color: Colors.red,
                  iconSize: 30,
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _showDeleteConfirmationDialog(sWorkout);
                  },
                ),
              ],
            ),
      ),
    ),
  );

  Future<void> _showDeleteConfirmationDialog(SavedWorkout sWorkout) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Workout'),
          content: const Text(
              'Are you sure you want to delete this workout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                final docWorkout =
                    FirebaseFirestore.instance.collection(useremail!).doc(sWorkout.id);
                docWorkout.delete();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> editWorkout(SavedWorkout sWorkout) async {

    await showDialog(
      context: context, 
      builder: (context) => EditWorkoutDialog(
        sWorkout: sWorkout, 
        setDate: DateConverter.convertBack(sWorkout.date),
        nameController: TextEditingController(text: sWorkout.name.toUpperCase()),
        sliderValue: sWorkout.sets,
        selectedIndex: sWorkout.repetitions,
        scrollController: FixedExtentScrollController(initialItem: sWorkout.repetitions)
      )
    );
  }
}