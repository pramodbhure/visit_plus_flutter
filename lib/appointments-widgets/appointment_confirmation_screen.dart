import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentConfirmationScreen extends StatelessWidget {
  final String doctorName;
  final String specialization;
  final DateTime appointmentTime;
  final String clinicAddress;
  final String paymentMode;
  final double consultationFee;
  final double totalPayable;

  const AppointmentConfirmationScreen({
    super.key,
    required this.doctorName,
    required this.specialization,
    required this.appointmentTime,
    required this.clinicAddress,
    required this.paymentMode,
    required this.consultationFee,
    required this.totalPayable,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/doctor_image.png'), // Add your image asset here
                  ),
                  const SizedBox(height: 10),
                  Text(
                    doctorName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    specialization,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 20.0), // Top padding
              child: Container(
                width: 362,
                height: 106,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFFD9E4EA),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Appointment Time',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 5),
                    Text(
                      DateFormat('EEE, MMMM d,hha').format(appointmentTime),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Clinic Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            const SizedBox(height: 7),
            Text(clinicAddress,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF73C2EF),
                  fixedSize: const Size(332, 58),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
// Handle confirm appointment
                },
                child: const Text(
                  'Confirm Appointment',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
