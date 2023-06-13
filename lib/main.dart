import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wegojim/auth_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
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
      body: const HomePage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Floating Action Button');
        },
        child: const Icon(
          Icons.messenger_rounded,
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_sharp, size: 30, color: Colors.red),
            label: 'Home',
          ),
          NavigationDestination(
              icon: Icon(Icons.calendar_today,
                  size: 30, color: Colors.red),
              label: 'My Workouts'),
          NavigationDestination(
              icon: Icon(Icons.person_outline_rounded,
                  size: 30, color: Colors.red),
              label: 'Profile',
              ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
