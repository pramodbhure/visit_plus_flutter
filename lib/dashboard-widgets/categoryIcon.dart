import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;

  const CategoryIcon({
    required this.icon,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey), // Adding grey border
          ),
          child: Icon(icon, size: 30, color: iconColor),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
