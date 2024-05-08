// ignore_for_file: prefer_final_fields, library_private_types_in_public_api, prefer_const_constructors, avoid_print, use_super_parameters

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visitplusapp/reusable_widget/reusable_widget.dart';
import 'package:visitplusapp/screens/home_screen.dart';
import 'package:visitplusapp/utils/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _mobileNumberTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("ffffffff"),
              hexStringToColor("ffffffff"),
              hexStringToColor("ffffffff")
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
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
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "VISIT +",
                    style: TextStyle(
                      color: Color(0xFF73C2EF),
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Enter Email Id", Icons.email, false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Mobile Number", Icons.phone, false,
                    _mobileNumberTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Confirm Password", Icons.lock_outlined, true,
                    _confirmPasswordTextController),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(height: 20),
                firebaseUIButton(context, "Sign Up", () {
                  if (_passwordTextController.text !=
                      _confirmPasswordTextController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Passwords do not match"),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    return;
                  }

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
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }).catchError((error) {
                    if (error.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'The account already exists for that email.',
                          ),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } else {
                      print("Error ${error.code}: ${error.message}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: ${error.message}'),
                          duration: Duration(seconds: 3),
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
