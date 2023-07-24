import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wegojim/components/my_button.dart';
import 'package:wegojim/components/my_textfield.dart';
import 'package:wegojim/login_page.dart';

// ignore: must_be_immutable
class MockLoginPage extends LoginPage {
  final MockFirebaseAuth auth;

  MockLoginPage({required this.auth});

  Future<String> signUserIn(String email, String password) async {

    if (email.isEmpty || password.isEmpty) {
      return "Please fill in all fields.";
    }

    if (!email.contains('.com') || !email.contains('@')) {
      return "Invalid Email"; 
    }

    if (password.length < 6) {
      return "Incorrect Password";
    }

    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'user-not-found';
      } else if (e.code == 'wrong-password') {
        return 'wrong-password';
      }
    }
    return "Failure";
  }
}

void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth(); // create auth in RegisterPage
  setUp(() {
    mockFirebaseAuth.createUserWithEmailAndPassword(
      email: 'testuser1@gmail.com', 
      password: 'testuser1'
    );
  });
  tearDown(() {});
  final MockLoginPage loginPage = MockLoginPage(
    auth: mockFirebaseAuth,
  );
  final Widget testWidget = MaterialApp(home: loginPage);

  testWidgets('Widget initializes and renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);
    expect(find.byType(MockLoginPage), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(MyButton), findsOneWidget);
    expect(find.byType(MyTextField), findsNWidgets(2));
  });

  testWidgets('Test the error message if all fields are empty', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);

    await tester.tap(find.byType(MyButton));

    await tester.pumpAndSettle();

    expect(find.text('Please fill in all fields.'), findsOneWidget);
  });

  testWidgets('Test the error message if email field is empty', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);

    // Perform the test
    await tester.enterText(find.widgetWithText(MyTextField, 'Password'), 'testuser1');

    await tester.tap(find.byType(MyButton));

    await tester.pumpAndSettle(); 

    expect(find.text('Please fill in all fields.'), findsOneWidget);
  });

  testWidgets('Test the error message if password field is empty', (WidgetTester tester) async {
    await tester.pumpWidget(testWidget);

    // Perform the test
    await tester.enterText(find.widgetWithText(MyTextField, 'Email'), 'testuser1@gmail.com');

    await tester.tap(find.byType(MyButton));

    await tester.pumpAndSettle();

    expect(find.text('Please fill in all fields.'), findsOneWidget);
  });

  testWidgets('Test the error message for a valid user email', (WidgetTester tester) async {    
    expect(
      await loginPage.signUserIn(
        'testuser1@gmail.com', 
        'testuser1', 
      ),
    'Success');
  });

  testWidgets('Test the error message for an invalid user email.', (WidgetTester tester) async {    
    expect(
      await loginPage.signUserIn(
        'testuser2@gmail.', 
        'testuser2', 
      ),
    'Invalid Email');
  });

  testWidgets('Test the error message for the incorrect password.', (WidgetTester tester) async {    
    expect(
      await loginPage.signUserIn(
        'testuser1@gmail.com', 
        'test', 
      ),
    'Incorrect Password');
  });
}
