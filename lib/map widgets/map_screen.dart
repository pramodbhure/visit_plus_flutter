import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:visitplusapp/firebase/firestore_service.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  String? _nextPageToken;
  final List<dynamic> _places = [];
  final LatLng _puneLocation =
      const LatLng(18.5204, 73.8567); // Pune coordinates

  @override
  void initState() {
    super.initState();
    _getNearbyDoctors();
  }

  void _getNearbyDoctors() async {
    await _firestoreService.getNearbyDoctors(
      _puneLocation.latitude,
      _puneLocation.longitude,
      _nextPageToken,
      _places,
    );
    setState(() {
      // Update the state to reflect any changes
    });
  }

  @override
  Widget build(BuildContext context) {
    // This is a placeholder widget, it can remain as is since no UI changes are needed
    return SizedBox.shrink();
  }
}
