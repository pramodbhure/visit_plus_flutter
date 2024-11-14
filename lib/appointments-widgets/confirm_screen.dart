import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visitplusapp/dashboard-widgets/bottom_navigation_bar.dart';

class ConfirmScreen extends StatelessWidget {
  final String doctorName;
  final String specialization;
  final DateTime appointmentTime;
  final String clinicAddress;

  const ConfirmScreen({
    super.key,
    required this.doctorName,
    required this.specialization,
    required this.appointmentTime,
    required this.clinicAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Appointment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Handle back button press
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/doctor3.jpeg',
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Image.asset(
                            'assets/vector.png',
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Your Appointment is Confirmed',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About Doctor',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF8A96BC),
                              height: 1.2,
                              fontFamily: 'Poppins',
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'Dr. $doctorName is a $specialization health professional who practices medicine.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Date & Time',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      DateFormat('d MMMM, hh:mm a').format(appointmentTime),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF8A96BC),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      clinicAddress,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF8A96BC),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          const CustomBottomNavigationBar(),
        ],
      ),
    );
  }
}
