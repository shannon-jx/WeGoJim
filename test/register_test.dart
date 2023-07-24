import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wegojim/components/my_button.dart';
import 'package:wegojim/components/my_textfield.dart';
import 'package:wegojim/register_page.dart';

class MockRegisterPage extends RegisterPage {
  final MockFirebaseAuth auth;
  final FakeFirebaseFirestore firestore;

  MockRegisterPage({required this.auth, required this.firestore});

  Future<String> signUserUp(String firstname, String lastname, String email, String password, String confirmPassword) async {

    if (firstname.isEmpty || lastname.isEmpty ||  email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return "Please fill in all fields.";
    }

    if (password.length < 6) {
      return "Weak Password";
    }

    if (!email.contains('.com') || !email.contains('@')) {
      return "Invalid Email"; 
    }

    try {
      if (password == confirmPassword) {
        await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        getDetails(firstname, lastname, email);
        return "Success";
      } else {
        return "Passwords don't match.";
      }
    } on FirebaseAuthException catch (e) {
      return e.code.toString();
    }
  }

  Future getDetails(String firstname, String lastname, String email) async {
    await firestore.collection('users').doc(email).set({
      'Name': '$firstname $lastname',
      'Email': email,
      'Height': '-',
      'Weight': '-'
    });
  }
}

void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth(); // create auth in RegisterPage
  final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
  final MockRegisterPage registerPage = MockRegisterPage(
    auth: mockFirebaseAuth,
    firestore: fakeFirebaseFirestore,
  );
  final Widget testWidget = MaterialApp(home: registerPage);
  setUp(() {});
  tearDown(() {});

  testWidgets('Widget initializes and renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      expect(find.byType(MockRegisterPage), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(MyButton), findsOneWidget);
      expect(find.byType(MyTextField), findsNWidgets(5));
    });

    // Test signUserUp method with empty fields
    testWidgets('Sign up fails with empty fields', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      // Tap the Sign Up button
      await tester.tap(find.byType(MyButton));

      // Wait for dialog to appear
      await tester.pumpAndSettle();

      // Check if the error message is shown
      expect(find.text('Please fill in all fields.'), findsOneWidget);
    });
    
    testWidgets('Test the error message for a valid user email', (WidgetTester tester) async {
      expect(
        await registerPage.signUserUp(
          'Tom',
          'Tan',
          'tomtan@gmail.com',
          'tomtan',
          'tomtan'
        ), 
        'Success'
      );
    });

    testWidgets('Test the error message for an invalid user email.', (WidgetTester tester) async {
      expect(
        await registerPage.signUserUp(
          'Tom',
          'Tan',
          'tomtan@gmail',
          'tomtan',
          'tomtan'
        ), 
        'Invalid Email'
      );
    });

    testWidgets('Test the error message for a weak password.', (WidgetTester tester) async {

      expect(
        await registerPage.signUserUp(
          'Tom',
          'Tan',
          'tomtan@gmail.com',
          '1',
          '1',
        ),
        'Weak Password',
      );
    });

    testWidgets('Test the error message for unmatched passwords.', (WidgetTester tester) async {
      expect(
        await registerPage.signUserUp(
          'Tom',
          'Tan',
          'tomtan@gmail.com',
          'tomtan1',
          'tomtan'
        ), 
        "Passwords don't match."
      );
    });
}