import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResumeProvider extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phoneNumber = '';
  String _linkedin = ''; // Added LinkedIn
  String _github = ''; // Added GitHub
  String _age = '';
  String _city = '';
  String _country = '';
  String _achievements = '';
  File? _photo;
  String _selectedTemplate = ''; // ✅ Template selection variable

  // Getters
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get linkedin => _linkedin; // Added LinkedIn getter
  String get github => _github; // Added GitHub getter
  String get age => _age;
  String get city => _city;
  String get country => _country;
  String get achievements => _achievements;
  File? get photo => _photo;
  String get selectedTemplate => _selectedTemplate; // ✅ Get selected template

  // Update Methods
  void updateFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void updateLastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updatePhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void updateLinkedin(String value) {
    // Added LinkedIn update
    _linkedin = value;
    notifyListeners();
  }

  void updateGithub(String value) {
    // Added GitHub update
    _github = value;
    notifyListeners();
  }

  void updateAge(String value) {
    _age = value;
    notifyListeners();
  }

  void updateCity(String value) {
    _city = value;
    notifyListeners();
  }

  void updateCountry(String value) {
    _country = value;
    notifyListeners();
  }

  void updateAchievements(String value) {
    _achievements = value;
    notifyListeners();
  }

  void updatePhoto(File image) {
    _photo = image;
    notifyListeners();
  }

  void updateSelectedTemplate(String template) {
    _selectedTemplate = template;
    notifyListeners();
  }

  // Function to submit the resume data to FastAPI
  Future<void> submitResume() async {
    final url = Uri.parse('http://127.0.0.1:8000/submit_resume');

    var request = http.MultipartRequest('POST', url);

    request.fields['first_name'] = _firstName;
    request.fields['last_name'] = _lastName;
    request.fields['email'] = _email;
    request.fields['phone_number'] = _phoneNumber;
    request.fields['linkedin'] = _linkedin; // Added LinkedIn
    request.fields['github'] = _github; // Added GitHub
    // Removed age, city, country from submission as per previous request
    // request.fields['age'] = _age;
    // request.fields['city'] = _city;
    // request.fields['country'] = _country;
    request.fields['achievements'] = _achievements;
    request.fields['template'] = _selectedTemplate; // ✅ Sending template

    if (_photo != null) {
      request.files.add(
        await http.MultipartFile.fromPath('photo', _photo!.path),
      );
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print("✅ Resume submitted successfully!");
        print("Response: $responseBody");
      } else {
        print("❌ Error: ${response.statusCode}");
        print("Response: $responseBody");
      }
    } catch (e) {
      print("❌ Exception: $e");
    }
  }
}
