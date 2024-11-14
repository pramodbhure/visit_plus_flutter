import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, Key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      top: 0,
      left: 0,
      width: screenWidth,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.13,
        ),
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
              fontSize: screenHeight * 0.05,
            ),
          ),
        ),
      ),
    );
  }
}
