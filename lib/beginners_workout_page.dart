import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wegojim/saved_detailed_workout.dart';

import 'components/date_converter.dart';
import 'components/saved_workout.dart';


class BeginnersWorkoutPage extends StatefulWidget {
  const BeginnersWorkoutPage({Key? key}) : super(key: key);

  @override
  State<BeginnersWorkoutPage> createState() => _BeginnersWorkoutPageState();
}

class _BeginnersWorkoutPageState extends State<BeginnersWorkoutPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beginner'),
      ),
    );
  }
}
