import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:intl/date_symbols.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkoutCalendarPage extends StatefulWidget {
  const WorkoutCalendarPage({Key? key}) : super(key: key);

  @override
  State<WorkoutCalendarPage> createState() => _WorkoutCalendarPageState();
}

class _WorkoutCalendarPageState extends State<WorkoutCalendarPage> {
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
    return Column(
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
                      255, 234, 122, 114), // Change the color for selected day
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.red, // Change the color for today
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
      ],
    );
  }
}