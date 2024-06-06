import 'package:flutter/material.dart';
import 'package:visitplusapp/widget/DoctorDetailsCard.dart';

class DoctorProfileScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorProfileScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/profile.png',
                        width: 100,
                        height: 93,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                doctor['name'],
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
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            height: 0.7 // Adjust lineHeight for minimal space
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'About Doctor\n',
                          ),
                        ],
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
                                'Dr. ${doctor['name']} is the topmost Cardiologist specialist in Nanyang Hospital at London. '
                                'She is available for private consultation.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
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
                    const SizedBox(height: 10),
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
                      onPressed: () {
                        // Implement your action here
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.lightBlue, // Background color
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
