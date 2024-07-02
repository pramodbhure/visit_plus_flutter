import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: const Color(0xFFFEFEFC),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontFamily: 'Poppins', fontSize: 32, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            fontFamily: 'Poppins', fontSize: 28, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(
            fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(
            fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(
            fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.normal),
        titleSmall: TextStyle(
            fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.normal),
        bodyLarge: TextStyle(
            fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.normal),
        bodyMedium: TextStyle(
            fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.normal),
        labelLarge: TextStyle(
            fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.bold),
        bodySmall: TextStyle(
            fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.normal),
        labelSmall: TextStyle(
            fontFamily: 'Poppins', fontSize: 10, fontWeight: FontWeight.normal),
      ),
    );
  }
}
