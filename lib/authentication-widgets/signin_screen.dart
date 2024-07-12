// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:visitplusapp/dashboard-widgets/home_screen.dart';
import 'package:visitplusapp/dashboard-widgets/header.dart';
import 'package:visitplusapp/authentication-widgets/sign_in_form.dart';
import 'package:visitplusapp/authentication-widgets/sign_up_option.dart';
import 'package:visitplusapp/authentication-widgets/social_sign_in_buttons.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;
        if (user != null) {
          // Fetch user's location
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

          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);

          print(
              'Latitude: ${position.latitude}, Longitude: ${position.longitude}');

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
          return user;
        }
      }
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    40, MediaQuery.of(context).size.height * 0.4, 35, 0),
                child: Column(
                  children: <Widget>[
                    SignInForm(
                      emailTextController: _emailTextController,
                      passwordTextController: _passwordTextController,
                    ),
                    const SizedBox(height: 20),
                    SocialSignInButtons(onGoogleSignIn: signInWithGoogle),
                    const SignUpOption(),
                  ],
                ),
              ),
            ),
          ),
          const Header(),
        ],
      ),
    );
  }
}
