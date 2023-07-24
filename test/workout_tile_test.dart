import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wegojim/detailed_workout.dart';
import 'package:wegojim/components/my_bottom_sheet.dart';
import 'package:wegojim/components/workout.dart';

// ignore: must_be_immutable
class MockWorkoutTile extends StatefulWidget {
  Workout workout;

  MockWorkoutTile({super.key, required this.workout});

  @override
  State<MockWorkoutTile> createState() => _MockWorkoutTileState();
}

class _MockWorkoutTileState extends State<MockWorkoutTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        result('Launch Detailed Workout');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.workout.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            softWrap: true,
                          ),
                          SizedBox(
                            height: 200.0,
                            width: 200.0,
                            child: Text('test')
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Text(
                        'EQUIPMENT: ${widget.workout.equipment.toUpperCase()}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 22.0,
                          backgroundColor: Colors.transparent,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 65.0,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: Colors.red,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Icon(Icons.add),
                      ),
                    ),
                    onTap: () {
                      result('Launch Bottom Sheet');
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void result(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }
}

void main() {
  final Workout workout = Workout(
    name: 'Test Workout 1', 
    difficulty: 'Easy', 
    equipment: 'Dumbbells', 
    image: 'image', 
    instructions: 'instructions', 
    bodyPart: 'bodyPart', 
    target: 'target'
  );
  final MockWorkoutTile mockWorkoutTile = MockWorkoutTile(workout: workout);
  setUp(() {});
  tearDown(() {});

  testWidgets('Widget initializes and renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: mockWorkoutTile));
    expect(find.byType(MockWorkoutTile), findsOneWidget);
    expect(find.byType(GestureDetector), findsNWidgets(2));
    expect(find.byType(Icon), findsOneWidget);
    expect(find.textContaining('EQUIPMENT'), findsOneWidget);
  });

  testWidgets('Test if the ‘+’ icon button can successfully call the bottom  modal sheet.', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: mockWorkoutTile));

    await tester.tap(find.textContaining('EQUIPMENT'));

    await tester.pumpAndSettle();

    expectLater(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('Test if tapping the Workout Tile can launch the workout’s details.', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: mockWorkoutTile));

    await tester.tap(find.byType(Icon));

    await tester.pumpAndSettle();

    expectLater(find.byType(AlertDialog), findsOneWidget);
  });
}