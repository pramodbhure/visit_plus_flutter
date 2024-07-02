import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:visitplusapp/dashboard-widgets/categoryIcon.dart';
import 'package:visitplusapp/dashboard-widgets/doctorCard.dart';
import 'package:visitplusapp/dashboard-widgets/bottom_navigation_bar.dart';
import 'package:visitplusapp/doctor-widgets/doctor_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference _doctorsRef =
      FirebaseFirestore.instance.collection('apiResponcedoctors');
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
      {
        'imagePath': 'assets/all.png',
        'label': 'All',
      },
      {
        'imagePath': 'assets/heart.png',
        'label': 'Cardiology',
      },
      {
        'imagePath': 'assets/tablet.png',
        'label': 'Medicine',
      },
      {
        'imagePath': 'assets/boy.png',
        'label': 'Pediatrician',
      },
      {
        'imagePath': 'assets/boy.png',
        'label': 'General',
      },
      {
        'imagePath': 'assets/boy.png',
        'label': 'Pediatrician',
      },
      // Add more categories as needed
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200], // Blue background color
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/menu.png', // Replace with your menu icon asset path
            width: 24,
            height: 24,
            color: Colors.black,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white, // White background color
              borderRadius: BorderRadius.circular(20.0), // Rounded corners
              image: const DecorationImage(
                image: AssetImage('assets/doctor1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            leading: const SizedBox(), // Removed leading from SliverAppBar
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Container(
                  color: Colors.blue[200],
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                                height:
                                    30.0), // Adjusted height to create space for search bar
                            Text(
                              'Let\'s find your top doctor!',
                              style: TextStyle(
                                fontSize: 36,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height:
                              30.0), // Adjusted height to create space for search bar
                    ],
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize:
                  const Size(0, 36), // Adjusted height to cover entire app bar
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[200], // Blue background color
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      16.0, 16.0, 16.0, 16.0), // Added top and bottom padding
                  child: Container(
                    height: 60.0,
                    alignment: Alignment.center,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const ImageIcon(
                          AssetImage(
                              'assets/search.png'), // Replace with your search icon image path
                          color: Colors
                              .grey, // Optionally set the color of the icon
                        ),
                        hintText: 'Search health issue.......',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: CategoryIcon(
                              imagePath: category['imagePath'],
                              label: category['label'],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          _doctors.isEmpty
              ? SliverFillRemaining(
                  child: const Center(child: CircularProgressIndicator()),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
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
                    childCount: _doctors.length,
                  ),
                ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
