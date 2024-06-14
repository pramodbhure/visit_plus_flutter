import 'package:flutter/material.dart';

class WelcomeScreen2 extends StatelessWidget {
  const WelcomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtain the screen size
    final screenSize = MediaQuery.of(context).size;
    // Define a base width for your design (e.g., the width of a typical phone screen)
    const baseWidth = 375.0;
    // Calculate the scaling factor
    final scaleFactor = screenSize.width / baseWidth;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Adjust the image size based on the scale factor
              Image.asset(
                'assets/doctor1.png',
                width: 384 * scaleFactor,
                height: 348 * scaleFactor,
              ),
              Padding(
                padding: EdgeInsets.all(13.0 * scaleFactor),
                child: Text(
                  'Health checks & Appointments Easily anytime, anywhere',
                  style: TextStyle(
                    fontSize: 32 * scaleFactor,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF73C2EF),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
