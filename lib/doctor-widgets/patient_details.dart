import 'dart:convert';
import 'dart:io';

class PatientDetails {
  String? name;
  int? age;
  String? gender;
  String? problem;
  File? image;

  PatientDetails({
    this.name,
    this.age,
    this.gender,
    this.problem,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'problem': problem,
      'image': image != null ? base64Encode(image!.readAsBytesSync()) : null,
    };
  }
}
