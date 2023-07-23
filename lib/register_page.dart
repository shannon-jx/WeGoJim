import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wegojim/auth_page.dart';
import 'package:wegojim/components/my_button.dart';
import 'package:wegojim/components/my_textfield.dart';
//import 'package:wegojim/login_page.dart';

class RegisterPage extends StatefulWidget {
  final FirebaseAuth? auth;
  final FirebaseFirestore? firestore;

  RegisterPage({super.key, this.auth, this.firestore});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<String> signUserUp(String firstname, String lastname, String email, String password, String confirmPassword) async {

    if (firstname.isEmpty || lastname.isEmpty ||  email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showErrorMessage("Please fill in all fields.");
      return "Please fill in all fields.";
    }

    try {
      if (password == confirmPassword) {
        FirebaseAuth auth = widget.auth ?? FirebaseAuth.instance;
        await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        getDetails(firstname, lastname, email);

        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AuthPage()));
        return "Success";
      } else {
        showErrorMessage("Passwords don't match.");
        return "Passwords don't match.";
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.code);
      return e.code.toString();
    }
  }

  Future getDetails(String firstname, String lastname, String email) async {
    FirebaseFirestore firestore = widget.firestore ?? FirebaseFirestore.instance;
    await firestore.collection('users').doc(email).set({
      'Name': '$firstname $lastname',
      'Email': email,
      'Height': '-',
      'Weight': '-'
    });
  }

  // error message popup
  void showErrorMessage(String message) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.black],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset('assets/logo.png'),
                  ),
      
                  const SizedBox(height: 50),
      
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Join us!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
      
                  const SizedBox(height: 25),
      
                  // Name textfield
                  MyTextField(
                    controller: firstnameController,
                    hintText: 'First Name',
                    obscureText: false,
                  ),
      
                  const SizedBox(height: 10),
      
                  MyTextField(
                    controller: lastnameController,
                    hintText: 'Last Name',
                    obscureText: false,
                  ),
      
                  const SizedBox(height: 10),
      
                  // email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
      
                  const SizedBox(height: 10),
      
                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
      
                  const SizedBox(height: 10),
      
                  // confirm password textfield
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
      
                  const SizedBox(height: 20),
      
                  MyButton(
                    onTap: () {signUserUp(
                      firstnameController.text.trim(),
                      lastnameController.text.trim(),
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      confirmPasswordController.text.trim()
                    );},
                    desc: 'Sign Up',
                  ),
      
                  const SizedBox(height: 50),
      
                  // have an account? login now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AuthPage()));
                        },
                        child: const Text(
                          'Login now.',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
