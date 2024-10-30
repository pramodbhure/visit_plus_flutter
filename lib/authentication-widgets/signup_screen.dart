// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:visitplusapp/reusable_widget/reusable_widget.dart';
import 'package:visitplusapp/dashboard-widgets/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _mobileNumberTextController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();

  Future<Position?> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return null;
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

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
                firebaseUIButton(context, "Sign Up", () async {
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
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text,
                    );

                    Position? position = await _getUserLocation();
                    if (position != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            latitude: position.latitude,
                            longitude: position.longitude,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Location services are disabled or permissions are denied"),
                          duration: Duration(seconds: 4),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'The account already exists for that email.'),
                          duration: Duration(seconds: 4),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: ${e.message}'),
                          duration: const Duration(seconds: 3),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        duration: const Duration(seconds: 4),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
