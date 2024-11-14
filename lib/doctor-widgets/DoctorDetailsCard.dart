import 'package:flutter/material.dart';

class DoctorDetailsCard extends StatelessWidget {
  final String number;
  final String text;
  final int color;

  const DoctorDetailsCard({
    super.key,
    required this.number,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define the width of the card as a fraction of the screen width
    final cardWidth = screenWidth * 0.25;

    // Define font sizes based on screen width
    final numberFontSize = screenWidth * 0.08; // Adjust as needed
    final textFontSize = screenWidth * 0.03; // Adjust as needed

    return SizedBox(
      width: cardWidth,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(3.0), // Add padding to all sides
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number,
                style: TextStyle(
                  fontSize: numberFontSize,
                  fontWeight: FontWeight.w600,
                  color: Color(color), // Set number color
                ),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textFontSize,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8A96BC), // Set text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
