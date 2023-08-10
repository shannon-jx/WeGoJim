import 'dart:io';
import 'dart:math';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:wegojim/components/my_bottom_sheet.dart';
import 'package:wegojim/components/paginated_firestore_list.dart';
import 'package:wegojim/components/workout.dart';
import 'package:wegojim/components/workout_tile.dart';
import 'package:wegojim/detailed_workout.dart';
import 'package:wegojim/indiv_muscle_page.dart';

class MockPaginated extends StatelessWidget {
  final String title;
  static String keywords = '';
  static String selectedEquipment = '';
  final FakeFirebaseFirestore firestore; 

  MockPaginated({super.key, required this.title, required this.firestore});

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      query: firestore.collection('data-${title.toLowerCase()}'),
      itemBuilderType: PaginateBuilderType.listView,
      itemsPerPage: 5,
      initialLoader: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      onEmpty: const Center(
        child: Text('Empty data!'),
      ),
      onError: (e) => const Center(
        child: CircularProgressIndicator(),
      ),
      bottomLoader: const Center(
        child: CircularProgressIndicator(),
      ),
      itemBuilder: (context, snapshot, index) {
        final Map<String, dynamic> json =
            snapshot[index].data() as Map<String, dynamic>;

        final workout = Workout(
            name: json['Name'],
            difficulty: json['Difficulty'],
            equipment: json['Equipment'],
            image: json['Image'],
            instructions: json['Instructions'],
            bodyPart: json['Body Part'],
            target: json['Target']);

        if (workout.name.toLowerCase().contains(keywords.toLowerCase()) 
          && (selectedEquipment.isEmpty 
            || workout.equipment.toLowerCase().contains(selectedEquipment))) {
          return MockWorkoutTile(workout: workout);
        } else {
          return Container();
        }
      },
    );
  }
}

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
        result("Launch Detailed Workout");
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
                            child: Text('image'),
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
                      result("Success");
                      /*showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return MyBottomSheet(workout: widget.workout);
                        },
                      );*/
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
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.runZoned(() {
    // Run your test here
    testWidgets('Test if the search bar controller can successfully filter - Legit search', (WidgetTester tester) async {
      final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
      final IndivMusclePage indivMusclePage = IndivMusclePage(title: 'Forearms', firestore: fakeFirebaseFirestore,);
      final Widget testWidget = MaterialApp(home: indivMusclePage);
      
      MockPaginated.keywords = 'Test';

      // Rebuild the widget tree
      await tester.pumpWidget(testWidget);

      expect(find.text('Dumbbells'), findsOneWidget);
    });
  });
  final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();

  final IndivMusclePage indivMusclePage = IndivMusclePage(title: 'Forearms', firestore: fakeFirebaseFirestore,);
  final Widget testWidget = MaterialApp(home: indivMusclePage);

  setUp(() {
    fakeFirebaseFirestore.collection('data-forearms').add({
      'Name': 'Test Workout 1',
      'Difficulty': 'Intermediate',
      'Equipment': 'Dumbbells',
      'Image': 'image',
      'Instructions': 'Do some exercises.',
      'Body Part': 'Forearms',
      'Target': 'Strength',
    });
  });

  tearDown(() {});

  testWidgets('Test if data is successfully retrieved from workout library', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);
    expect(find.byType(IndivMusclePage), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Dumbbells'), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byType(PaginatedFirestoreList), findsOneWidget);
  });
}