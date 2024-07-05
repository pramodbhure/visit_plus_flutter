import 'package:flutter/material.dart';
import 'CalendarSection.dart';

class AppointmentSection extends StatefulWidget {
  final String doctorId; // Add doctorId parameter

  // ignore: use_super_parameters
  const AppointmentSection({Key? key, required this.doctorId})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppointmentSectionState createState() => _AppointmentSectionState();
}

class _AppointmentSectionState extends State<AppointmentSection> {
  bool showCalendar = false;

  void toggleCalendar() {
    setState(() {
      showCalendar = !showCalendar;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return showCalendar
        ? CalendarSection(doctorId: widget.doctorId)
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.asset(
                      'assets/hospital.jpeg',
                      width: screenWidth * 0.9,
                      height: screenWidth * 0.45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "You can book\n the appointment right now!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Implement your action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(screenWidth * 0.9, 58),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          "Queue Me Up",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          "(20 patients in the queue)",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: toggleCalendar,
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF73C2EF),
                      minimumSize: Size(screenWidth * 0.9, 58),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      "Schedule Appointment",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
