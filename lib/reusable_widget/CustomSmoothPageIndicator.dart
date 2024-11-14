import 'package:flutter/material.dart';

class CustomPageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;
  final bool isVisible;

  const CustomPageIndicator({
    required this.controller,
    required this.count,
    required this.isVisible,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? Padding(
            padding: const EdgeInsets.only(
                bottom: 30.0), // Add padding from the bottom
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(count * 2 - 1, (index) {
                if (index.isEven) {
                  // Dot
                  final double currentPage = (controller.page?.round() ?? 0)
                      .toDouble(); // Using toDouble() to ensure the type is double
                  final bool isActive = currentPage >=
                      index ~/ 2; // Ensure isActive is explicitly typed as bool
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey), // Add grey border
                      color: isActive
                          ? const Color(0xFF73C2EF)
                          : Colors.transparent, // Fill blue for active dot
                    ),
                  );
                } else {
                  // Line
                  return Container(
                    width: 40,
                    height: 1,
                    color: const Color(0xFF73C2EF),
                  );
                }
              }),
            ),
          )
        : const SizedBox.shrink();
  }
}
