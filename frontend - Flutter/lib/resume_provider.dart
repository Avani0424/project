import 'package:flutter/foundation.dart';

class ResumeProvider extends ChangeNotifier {
  // Existing private variables
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phoneNumber = '';
  String _linkedin = '';
  String _github = '';

  // New private variable for achievements
  String _achievements = '';
  String _selectedTemplate = '';

  // Getters for existing fields
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get linkedin => _linkedin;
  String get github => _github;

  // Getter for achievements
  String get achievements => _achievements;
  String get selectedTemplate => _selectedTemplate;

  // Setters with notifyListeners for existing fields
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
    _linkedin = value;
    notifyListeners();
  }

  void updateGithub(String value) {
    _github = value;
    notifyListeners();
  }

  // Setter with notifyListeners for achievements
  void updateAchievements(String value) {
    _achievements = value;
    notifyListeners();
  }

  void updateSelectedTemplate(String template) {
    _selectedTemplate = template;
    notifyListeners();
  }
}
