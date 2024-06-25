// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'CalendarSection.dart';

class AppointmentSection extends StatefulWidget {
  final String doctorId; // Add doctorId parameter

  const AppointmentSection({Key? key, required this.doctorId})
      : super(key: key);

  @override
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
    return showCalendar
        ? CalendarSection(doctorId: widget.doctorId)
        : Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(
                    'assets/hospital.jpeg',
                    width: 332,
                    height: 172,
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
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    // Implement your action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    fixedSize: const Size(332, 58),
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
                    backgroundColor:
                        const Color(0xFF73C2EF), // Background color
                    fixedSize: const Size(332, 58),
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
          );
  }
}
