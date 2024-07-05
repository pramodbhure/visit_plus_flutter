import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive padding based on screen width
    final double padding = screenWidth * 0.04; // 4% of screen width as padding

    return Padding(
      padding: EdgeInsets.only(
          left: padding,
          right: padding,
          bottom: 20,
          top: 10), // Adjust vertical padding for spacing
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0), // Add border radius
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Set the background color to white
            borderRadius: BorderRadius.circular(30.0), // Add border radius
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 5), // Adjust shadow position
              ),
            ],
          ),
          child: Material(
            color: Colors.white, // Set the background color to white
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ImageIcon(
                      const AssetImage('assets/home.png'),
                      size: 0.09 * screenWidth, // Responsive icon size
                      color: Colors.blue, // Active icon color
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ImageIcon(
                      const AssetImage('assets/calendar.png'),
                      size: 0.09 * screenWidth, // Responsive icon size
                      color: Colors.grey, // Inactive icon color
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ImageIcon(
                          const AssetImage('assets/message.png'),
                          size: 0.09 * screenWidth, // Responsive icon size
                          color: Colors.grey, // Inactive icon color
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 15,
                              minHeight: 15,
                            ),
                            child: const Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ImageIcon(
                      const AssetImage('assets/user.png'),
                      size: 0.09 * screenWidth, // Responsive icon size
                      color: Colors.grey, // Inactive icon color
                    ),
                  ),
                  label: '',
                ),
              ],
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
