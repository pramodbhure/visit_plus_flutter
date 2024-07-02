import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.15), // Adjusted padding proportionally
        decoration: const BoxDecoration(
          color: Color(0xFF73C2EF),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Center(
          child: Text(
            "VISIT +",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize:
                  screenHeight * 0.06, // Adjusted font size proportionally
            ),
          ),
        ),
      ),
    );
  }
}
