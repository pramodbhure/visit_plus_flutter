// ignore_for_file: file_names

import 'package:flutter/material.dart';

class WelcomeScreen3 extends StatelessWidget {
  const WelcomeScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/doctor2.png',
              width: 384,
              height: 348,
            ),
            const Padding(
              padding: EdgeInsets.all(13.0),
              child: Text(
                'More than 1000 \n doctors around you',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF73C2EF),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
