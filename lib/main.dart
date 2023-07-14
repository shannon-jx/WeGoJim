import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wegojim/auth_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:wegojim/profile_page.dart';
import 'firebase_options.dart';
import 'home_page.dart';
import 'workout_calendar_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red, // Change the primary color
        hintColor: Colors.grey[400], // Change the accent color
      ),
      home: const AuthPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPageIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    const WorkoutCalendarPage(),
    ProfilePage(),
  ];

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
  }

  void navigateToPage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          width: 120,
          height: 120,
          color: Colors.red,
        ),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.red,
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          onTap: navigateToPage,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          currentIndex: currentPageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_sharp),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'My Workouts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
