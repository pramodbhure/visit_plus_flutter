import 'package:flutter/material.dart';
import 'package:visitplusapp/dashboard-widgets/doctorCard.dart';
import 'package:visitplusapp/appointments-widgets/AppointmentSection.dart';
import 'package:visitplusapp/doctor-widgets/DoctorDetailsCard.dart';

class DoctorProfileScreen extends StatelessWidget {
  final Doctor doctor; // Change type to Doctor

  // ignore: use_super_parameters
  const DoctorProfileScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the desired background color
        title: const Text(
          "Appointment",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        width: 89, // Adjusted width
                        height: 93, // Adjusted height
                        color: Colors.blue,
                        child: Image.asset(
                          doctor.imageUrl ??
                              'assets/hospital.png', // Use default
                          fit: BoxFit
                              .cover, // Ensure the image covers the container
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                doctor.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              const Card(
                margin: EdgeInsets.all(20.0),
                color: Color(0xFFD9E4EA), // Set text color to #D9E4E
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DoctorDetailsCard(
                          number: '350', text: 'Patient', color: 0xFF73C2EF),
                      DoctorDetailsCard(
                          number: '15', text: 'Experience', color: 0xFF9DEAC0),
                      DoctorDetailsCard(
                          number: '284', text: 'Reviews', color: 0xFFFF9A9A),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 30, right: 30, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft, // Align to the start
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              height: 0.7 // Adjust lineHeight for minimal space
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'About Doctor\n',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft, // Align to the start
                      child: RichText(
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
                                    'Dr. ${doctor.name} is the ${doctor.description}  health professional who practices medicine.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppointmentSection(doctorId: doctor.id), // Pass doctorId here
            ],
          ),
        ),
      ),
    );
  }
}
