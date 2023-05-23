import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wegojim/auth_page.dart';
import 'package:wegojim/home_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
      theme: ThemeData(primarySwatch: Colors.red),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        elevation: 0,
        title: const Text('WeGoJim', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout, color: Colors.black,),
          ),
        ],
      ),
      body: const HomePage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Floating Action Button');
        },
        child: const Icon(Icons.messenger_rounded, color: Colors.black,),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.red,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_sharp, size: 30), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.add_circle, size: 30), label: 'Add'),
          NavigationDestination(
              icon: Icon(Icons.person_outline_rounded, size: 30), label: 'Profile'),
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
