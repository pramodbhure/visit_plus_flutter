import 'package:flutter/material.dart';

class DoctorDetailsCard extends StatelessWidget {
  final String number;
  final String text;
  final int color;

  // ignore: use_super_parameters
  const DoctorDetailsCard(
      {Key? key, required this.number, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 104, // Specify the width of the card
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
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Color(color), // Set number color
                ),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF8A96BC), // Set text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
