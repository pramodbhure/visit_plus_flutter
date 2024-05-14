import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:visitplusapp/firebase_options.dart';
import 'package:visitplusapp/screens/signin_screen.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    name: 'visit-plus-app',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run your app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInScreen(),
    );
  }
}
