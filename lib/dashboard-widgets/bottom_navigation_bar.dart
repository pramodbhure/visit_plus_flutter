import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive padding based on screen width
    final double padding = screenWidth * 0.05; // 5% of screen width as padding

    return Padding(
      padding: EdgeInsets.all(padding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ImageIcon(
                    const AssetImage('assets/home.png'),
                    size: 0.06 * screenWidth, // Responsive icon size
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ImageIcon(
                    const AssetImage('assets/calendar.png'),
                    size: 0.06 * screenWidth, // Responsive icon size
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ImageIcon(
                    const AssetImage('assets/message.png'),
                    size: 0.06 * screenWidth, // Responsive icon size
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ImageIcon(
                    const AssetImage('assets/user.png'),
                    size: 0.06 * screenWidth, // Responsive icon size
                  ),
                ),
                label: '',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
