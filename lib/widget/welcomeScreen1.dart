// ignore_for_file: file_names

import 'package:flutter/material.dart';

class WelcomeScreen1 extends StatelessWidget {
  const WelcomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'VISIT +',
          style: TextStyle(
            fontSize: 42, // Set the font size
            fontWeight: FontWeight.w700, // Set the font weight
            color: Color(0xFF73C2EF),
          ),
        ),
      ),
    );
  }
}
