import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wegojim/components/my_bottom_sheet.dart';
import 'package:wegojim/components/workout.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wegojim/components/date_converter.dart';
import 'package:wegojim/components/my_button.dart';
import 'package:wegojim/components/workout.dart';

class MockBottomSheet extends StatefulWidget {
  final Workout workout;

  const MockBottomSheet({super.key, required this.workout});

  @override
  State<MockBottomSheet> createState() => _MockBottomSheetState();
}

class _MockBottomSheetState extends State<MockBottomSheet> {
  DateTime _setDate = DateTime.now();
  double _sliderValue = 1;
  int selectedIndex = 0;
  final _scrollController = FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                result('Successfully Saved to Calendar');
              },
              desc: 'Save to Calendar'
            )
          ],
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
  final MockBottomSheet mockBottomSheet = MockBottomSheet(workout: workout);
  setUp(() {});
  tearDown(() {});

  testWidgets('Widget initializes and renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: mockBottomSheet));
    expect(find.byType(MockBottomSheet), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
    expect(find.byType(ListWheelScrollView), findsOneWidget);
    expect(find.byType(MyButton), findsOneWidget);
  });

  testWidgets('Test if the date picker can successfully set the state and change the date.', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: mockBottomSheet));
    
    await tester.tap(find.byType(TextButton));

    await tester.pumpAndSettle();

    expectLater(find.byType(Dialog), findsOneWidget);

    await tester.tap(find.text('7'));

    await tester.pumpAndSettle();

    await tester.tap(find.text('7'));

    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));

    await tester.pumpAndSettle();

    expectLater(find.textContaining('7/'), findsOneWidget);
  });

  testWidgets('Test if the slider controller can successfully select the number of sets.', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: mockBottomSheet));
    
    expect(find.text('1'), findsAtLeastNWidgets(1));

    // Find the Slider widget
    final sliderFinder = find.byType(Slider);

    // Drag the slider to the right to set the value to 5
    await tester.drag(sliderFinder, const Offset(500.0, 0.0));
    await tester.pumpAndSettle();

    // Verify if the value is updated correctly
    expect(find.text('5'), findsAtLeastNWidgets(1));
  });

  testWidgets('Test if the FixedExtentScrollController can successfully select the number of repetitions.', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(home: mockBottomSheet));

    // Ensure that the initial selected value is '1'
    expect(find.text('1'), findsAtLeastNWidgets(1));

    // Find the ListWheelScrollView widget
    final scrollFinder = find.byType(ListWheelScrollView);

    // Drag the scroll upwards to select a different number of repetitions, e.g., '5'
    await tester.drag(scrollFinder, const Offset(0.0, -250.0));
    await tester.pumpAndSettle();

    // Verify if the selected value is updated correctly to '5'
    expect(find.text('5'), findsOneWidget);
  });
}