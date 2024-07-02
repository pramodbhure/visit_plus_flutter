import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final String imagePath;
  final String label;

  const CategoryIcon({
    super.key,
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;
    // Calculate size based on screen width
    double containerSize = screenWidth * 0.17; // 15% of screen width
    double imageSize = containerSize * 0.5; // 50% of container size

    return SizedBox(
      child: Column(
        children: [
          Container(
            width: containerSize,
            height: containerSize,
            padding:
                EdgeInsets.all(containerSize * 0.1), // 10% padding inside box
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  containerSize * 0.2), // 20% border radius
              border: Border.all(
                color: const Color(0xFFEBE7E7),
              ),
            ),
            child: Center(
              child: Image.asset(imagePath, height: imageSize),
            ),
          ),
          SizedBox(height: containerSize * 0.1), // 10% margin at the bottom
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10, // Set font size to 10 pixels
              color: Color(0xFF7D8BB7), // Set text color to #7D8BB7
            ),
          )
        ],
      ),
    );
  }
}
