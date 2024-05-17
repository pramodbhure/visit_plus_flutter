import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:visitplusapp/dashboard-widgets/CategoryIcon.dart';
import 'package:visitplusapp/dashboard-widgets/DoctorCard.dart';
import 'package:visitplusapp/screens/signin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference _doctorsRef =
      FirebaseDatabase.instance.ref().child('doctors');
  List<Map<dynamic, dynamic>> _doctors = [];

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  void _fetchDoctors() {
    _doctorsRef.onValue.listen((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      List<Map<dynamic, dynamic>> fetchedDoctors = [];
      for (var doctor in snapshot.children) {
        fetchedDoctors.add(doctor.value as Map<dynamic, dynamic>);
      }
      setState(() {
        _doctors = fetchedDoctors;
        print('Fetched doctors: $_doctors'); // Log fetched data
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(350),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Container(
            color: Colors.blue[200], // Set the background color to blue
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      // child: CircleAvatar(
                      //   backgroundImage:
                      //       NetworkImage('https://example.com/profile.jpg'),
                      // ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.black),
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          print("Signed Out");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()),
                          );
                        });
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
                children: [
                  CategoryIcon(
                      icon: Icons.category,
                      label: 'All',
                      iconColor: Colors.green[200] ?? Colors.green),
                  CategoryIcon(
                    icon: Icons.favorite_border,
                    label: 'Cardiology',
                    iconColor: Colors.red[200] ?? Colors.red,
                  ),
                  CategoryIcon(
                    icon: Icons.medical_services,
                    label: 'Medicine',
                    iconColor: Colors.purple[200] ?? Colors.purple,
                  ),
                  CategoryIcon(
                    icon: Icons.healing,
                    label: 'General',
                    iconColor: Colors.red[200] ?? Colors.red,
                  ),
                ],
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
                          child: DoctorCard(
                            name: doctor['name'],
                            specialization: doctor['specialization'],
                            rating: (doctor['rating'] as num).toDouble(),
                            imageUrl: doctor['imageUrl'],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
