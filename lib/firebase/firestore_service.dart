import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visitplusapp/doctor-widgets/patient_details.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _apiKey =
      'AIzaSyDxWbJeOP5T-vqqKk9Ta2eALeo65NDNp14'; // Replace with your Google API key

  Future<Map<String, dynamic>?> getDoctorDetails(String doctorId) async {
    try {
      DocumentSnapshot doc =
          await _db.collection('apiResponcedoctors').doc(doctorId).get();
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

  Future<void> saveDoctorsToApiResponceDoctorsCollection(
      List<dynamic> places) async {
    final CollectionReference doctorsRef = _db.collection('apiResponcedoctors');

    // Clear existing data before adding new doctors
    try {
      // Get all documents in the collection
      var snapshot = await doctorsRef.get();
      // Delete each document in a batch
      var batch = _db.batch();
      snapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });
      // Commit the batch
      await batch.commit();
      print("Previous doctors data cleared from Firestore.");
    } catch (e) {
      print("Error clearing previous doctors data: $e");
    }

    try {
      // Add new doctors
      for (var place in places) {
        final details = await _getPlaceDetails(place['place_id']);

        await doctorsRef.add({
          'name': place['name'],
          'vicinity': place['vicinity'],
          'business_status': place['business_status'],
          'latitude': place['geometry']['location']['lat'],
          'longitude': place['geometry']['location']['lng'],
          'image': details['photoUrl'],
          'specialization': details['types'],
          'rating': details['rating'],
        });
      }
      print(
          "Doctors saved to Firestore successfully in collection apiResponcedoctors.");
    } catch (e) {
      print("Error saving doctors to Firestore: $e");
    }
  }

  Future<Map<String, dynamic>> _getPlaceDetails(String placeId) async {
    final detailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_apiKey';
    try {
      final response = await http.get(Uri.parse(detailsUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK' && data['result'] != null) {
          final result = data['result'];
          String photoUrl = '';
          if (result['photos'] != null && result['photos'].isNotEmpty) {
            final photoReference = result['photos'][0]['photo_reference'];
            photoUrl =
                'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$_apiKey';
          }
          return {
            'photoUrl': photoUrl,
            'types': result['types']?.join(', ') ?? 'General',
            'rating': result['rating'] ?? 0.0,
          };
        }
      }
    } catch (e) {
      print("Error fetching place details: $e");
    }
    return {'photoUrl': '', 'types': 'General', 'rating': 0.0};
  }

  Future<void> getNearbyDoctors(double latitude, double longitude,
      String? nextPageToken, List<dynamic> places) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=5000&type=doctor&key=$_apiKey';

    if (nextPageToken != null) {
      url += '&pagetoken=$nextPageToken';
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        print("Nearby places data: " + jsonEncode(data));

        if (data['status'] == 'OK' &&
            data['results'] != null &&
            data['results'].isNotEmpty) {
          places.addAll(data['results']);
          nextPageToken = data['next_page_token'];
          await saveDoctorsToApiResponceDoctorsCollection(data['results']);
        } else {
          print("No places found or API returned status: ${data['status']}");
        }
      } else {
        throw Exception('Failed to load nearby doctors');
      }
    } catch (e) {
      print("Error fetching nearby doctors: $e");
    }
  }
}
