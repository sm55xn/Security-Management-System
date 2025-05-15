 import 'package:flutter/material.dart';


//part 'Profile_model.g.dart';

class ProfileData {
   int id;
  final int NumberPhone;
  final String? selectedGender;
  final String? selectedDateBirthValue;
  final String fullName;
  final ImageProvider? imageProvider;

  ProfileData( {
    required this.id,
    this.imageProvider,
    required this.NumberPhone,
    required this.fullName,
    this.selectedDateBirthValue,
    this.selectedGender,
  });

//Profile Data to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageFilePath': imageProvider,
      'NumberPhone': NumberPhone,
      'fullName': fullName,
      'selectedDateBirthValue': selectedDateBirthValue,
      'selectedGender': selectedGender,
    };
  }
  
}
