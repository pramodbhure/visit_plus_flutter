// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visitplusapp/reusable_widget/reusable_widget.dart';
import 'package:visitplusapp/screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _mobileNumberTextController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              35,
              MediaQuery.of(context).size.height * 0.2,
              35,
              0,
            ),
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "VISIT +",
                    style: TextStyle(
                      color: Color(0xFF73C2EF),
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                reusableTextField(
                    "Enter Email Id", Icons.email, false, _emailTextController),
                const SizedBox(height: 20),
                reusableTextField("Enter Mobile Number", Icons.phone, false,
                    _mobileNumberTextController),
                const SizedBox(height: 20),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(height: 20),
                reusableTextField("Confirm Password", Icons.lock_outlined, true,
                    _confirmPasswordTextController),
                const SizedBox(height: 20),
                firebaseUIButton(context, "Sign Up", () {
                  // Check if any field is empty
                  if (_emailTextController.text.isEmpty ||
                      _mobileNumberTextController.text.isEmpty ||
                      _passwordTextController.text.isEmpty ||
                      _confirmPasswordTextController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("All fields are required"),
                        duration: Duration(seconds: 4),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                      .hasMatch(_emailTextController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Invalid email format"),
                        duration: Duration(seconds: 4),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Check if passwords match
                  if (_passwordTextController.text !=
                      _confirmPasswordTextController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Passwords do not match"),
                        duration: Duration(seconds: 4),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Check if mobile number is valid
                  if (_mobileNumberTextController.text.length != 10) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Mobile number must be exactly 10 digits"),
                        duration: Duration(seconds: 4),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Proceed with sign-up
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text,
                  )
                      .then((value) {
                    print("Created New Account");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }).catchError((error) {
                    if (error.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'The account already exists for that email.'),
                          duration: Duration(seconds: 4),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      print("Error ${error.code}: ${error.message}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: ${error.message}'),
                          duration: const Duration(seconds: 3),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
