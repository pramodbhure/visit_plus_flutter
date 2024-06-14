import 'package:flutter/material.dart';

class AppointmentConfirmationScreen extends StatelessWidget {
  final String doctorName;
  final String specialization;
  final DateTime appointmentTime;
  final String clinicAddress;
  final String paymentMode;
  final double consultationFee;
  final double totalPayable;

  const AppointmentConfirmationScreen({
    Key? key,
    required this.doctorName,
    required this.specialization,
    required this.appointmentTime,
    required this.clinicAddress,
    required this.paymentMode,
    required this.consultationFee,
    required this.totalPayable,
  }) : super(key: key);

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
            Text('Doctor: $doctorName', style: const TextStyle(fontSize: 18)),
            Text('Specialization: $specialization',
                style: const TextStyle(fontSize: 18)),
            Text('Appointment Time: $appointmentTime',
                style: const TextStyle(fontSize: 18)),
            Text('Clinic Address: $clinicAddress',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
