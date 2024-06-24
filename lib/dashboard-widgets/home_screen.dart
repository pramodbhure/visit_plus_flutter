import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:visitplusapp/dashboard-widgets/CategoryIcon.dart';
import 'package:visitplusapp/dashboard-widgets/doctorCard.dart';

import 'package:visitplusapp/dashboard-widgets/bottom_navigation_bar.dart';
import 'package:visitplusapp/doctor-widgets/doctor_profile_screen.dart';
import 'package:visitplusapp/map%20widgets/map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference _doctorsRef =
      FirebaseFirestore.instance.collection('doctors');
  List<Doctor> _doctors = [];
  late StreamSubscription<QuerySnapshot> _subscription;

  @override
  void initState() {
    super.initState();
    _subscribeToDoctors();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _subscribeToDoctors() {
    _subscription = _doctorsRef.snapshots().listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Doctor> fetchedDoctors = snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          String imageUrl = data.containsKey('imageUrl')
              ? data['imageUrl'] as String
              : Doctor.defaultImageUrl;

          return Doctor(
              id: doc.id,
              name: data['name'] ?? 'Unknown',
              specialization: data['specialization'] ?? 'General',
              rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
              imageUrl: imageUrl,
              description: data['description'] ?? "",
              address: data['address'] ?? "");
        }).toList();
        setState(() {
          _doctors = fetchedDoctors;
        });
      } else {
        print('No doctors found.');
      }
    }, onError: (error) {
      print('Error fetching doctors: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {'icon': Icons.category, 'label': 'All', 'color': Colors.green[200]},
      {
        'icon': Icons.favorite_border,
        'label': 'Cardiology',
        'color': Colors.red[200]
      },
      {
        'icon': Icons.medical_services,
        'label': 'Medicine',
        'color': Colors.purple[200]
      },
      {'icon': Icons.healing, 'label': 'General', 'color': Colors.red[200]},
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(350),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Container(
            color: Colors.blue[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.menu, color: Colors.black),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.black),
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          print("Signed Out");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapScreen()),
                          );
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.map, color: Colors.black),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapScreen()),
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Let\'s find your top doctor!',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search health issue.......',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: categories.map((category) {
                  return CategoryIcon(
                    icon: category['icon'],
                    label: category['label'],
                    iconColor: category['color'] ?? Colors.green,
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _doctors.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _doctors.length,
                      itemBuilder: (context, index) {
                        final doctor = _doctors[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Doctor(
                            id: doctor.id,
                            name: doctor.name,
                            specialization: doctor.specialization,
                            rating: doctor.rating,
                            imageUrl: doctor.imageUrl,
                            description: doctor.description,
                            address: doctor.address,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DoctorProfileScreen(doctor: doctor)),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
