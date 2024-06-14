import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visitplusapp/doctor-widgets/patient_details.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getDoctorDetails(String doctorId) async {
    try {
      DocumentSnapshot doc =
          await _db.collection('doctors').doc(doctorId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>?;
      }
    } catch (e) {
      print('Error fetching doctor details: $e');
    }
    return null;
  }

  Future<void> bookAppointment(
      DateTime date, String time, PatientDetails patientDetails) async {
    try {
      await _db.collection('appointments').add({
        'date': date,
        'time': time,
        'patientName': patientDetails.name,
        'patientAge': patientDetails.age,
        'patientGender': patientDetails.gender,
        'patientProblem': patientDetails.problem,
        'patientImage': patientDetails.image?.path,
      });
    } catch (e) {
      print('Error booking appointment: $e');
    }
  }
}
