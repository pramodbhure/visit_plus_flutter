// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visitplusapp/reusable_widget/reusable_widget.dart';
import 'package:visitplusapp/dashboard-widgets/home_screen.dart';
import 'package:visitplusapp/authentication-widgets/reset_password.dart';

class SignInForm extends StatelessWidget {
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;

  const SignInForm({
    super.key,
    required this.emailTextController,
    required this.passwordTextController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        reusableTextField("Enter email i’d", Icons.person_outline, false,
            emailTextController),
        const SizedBox(height: 20),
        reusableTextField(
            "Enter Password", Icons.lock_outline, true, passwordTextController),
        const SizedBox(height: 5),
        forgetPassword(context),
        firebaseUIButton(context, "Login", () async {
          // Validate email and password fields
          if (emailTextController.text.isEmpty ||
              passwordTextController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("All fields are required"),
                duration: Duration(seconds: 4),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          // Validate email format
          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
              .hasMatch(emailTextController.text)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Invalid email format"),
                duration: Duration(seconds: 4),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          // Attempt to sign in with Firebase
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailTextController.text,
              password: passwordTextController.text,
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } on FirebaseAuthException catch (e) {
            String errorMessage;
            if (e.code == 'user-not-found') {
              errorMessage = 'No user found for that email.';
            } else if (e.code == 'wrong-password') {
              errorMessage = 'Wrong password provided.';
            } else {
              errorMessage = 'Invalid credentials, Please try again.';
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                duration: const Duration(seconds: 4),
                backgroundColor: Colors.red,
              ),
            );
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
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}
