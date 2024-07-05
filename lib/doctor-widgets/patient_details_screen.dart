import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:visitplusapp/dashboard-widgets/doctorCard.dart';
import 'package:visitplusapp/firebase/firestore_service.dart';
import '../appointments-widgets/appointment_confirmation_screen.dart';

import 'patient_details.dart';

class PatientDetailsScreen extends StatefulWidget {
  final DateTime selectedDate;
  final String selectedTime;
  final String doctorId;

  const PatientDetailsScreen({
    Key? key,
    required this.selectedDate,
    required this.selectedTime,
    required this.doctorId,
  }) : super(key: key);

  @override
  _PatientDetailsScreenState createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();
  final FocusNode _problemFocusNode = FocusNode();
  String? _gender;
  File? _image;

  final PatientDetails _patientDetails = PatientDetails();
  Doctor? _doctor;

  @override
  void initState() {
    super.initState();
    _fetchDoctorDetails();
  }

  Future<void> _fetchDoctorDetails() async {
    final firestoreService = FirestoreService();
    final doctorData = await firestoreService.getDoctorDetails(widget.doctorId);
    setState(() {
      _doctor = Doctor(
        id: widget.doctorId,
        name: doctorData?['name'] ?? 'Unknown',
        specialization: doctorData?['specialization'] ?? 'General',
        rating: (doctorData?['rating'] as num?)?.toDouble() ?? 0.0,
        imageUrl: doctorData?['imageUrl'] ?? Doctor.defaultImageUrl,
        description: doctorData?['description'] ?? '',
        address: doctorData?['vicinity'] ?? '',
      );
    });
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _patientDetails.image = _image;
      });
    }
  }

  void _confirmAppointment() async {
    if (_patientDetails.name != null &&
        _patientDetails.age != null &&
        _patientDetails.gender != null &&
        _patientDetails.problem != null &&
        _doctor != null) {
      final firestoreService = FirestoreService();
      await firestoreService.bookAppointment(
        widget.selectedDate,
        widget.selectedTime,
        _patientDetails,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppointmentConfirmationScreen(
            doctorName: _doctor!.name,
            specialization: _doctor!.specialization,
            appointmentTime: widget.selectedDate,
            clinicAddress: _doctor!.address,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields.'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_doctor == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
      ),
      body: GestureDetector(
        onTap: _unfocusAll,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _getImage,
                  child: Center(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            width: 89,
                            height: 93,
                            color: const Color(0xFFEFE7FF),
                            child: _image != null
                                ? Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  )
                                : const Center(
                                    child: Text(
                                      '  ADD\nPHOTO',
                                      style: TextStyle(
                                        color: Color(0xFFC3A7FD),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  focusNode: _nameFocusNode,
                  onChanged: (value) {
                    _patientDetails.name = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Patient\'s Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  focusNode: _ageFocusNode,
                  onChanged: (value) {
                    _patientDetails.age = int.tryParse(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Gender',
                  style: TextStyle(fontSize: 16),
                ),
                IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: 'male',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                            _patientDetails.gender = value;
                          });
                        },
                      ),
                      const Text('Male'),
                      const SizedBox(width: 10),
                      Radio<String>(
                        value: 'female',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                            _patientDetails.gender = value;
                          });
                        },
                      ),
                      const Text('Female'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  focusNode: _problemFocusNode,
                  onChanged: (value) {
                    _patientDetails.problem = value;
                  },
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Write Your Problem',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Expected Time to Visit: ${widget.selectedTime}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF73C2EF),
                          fixedSize: const Size(332, 58),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _confirmAppointment,
                        child: const Text(
                          'Confirm',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _unfocusAll() {
    _nameFocusNode.unfocus();
    _ageFocusNode.unfocus();
    _problemFocusNode.unfocus();
  }
}
