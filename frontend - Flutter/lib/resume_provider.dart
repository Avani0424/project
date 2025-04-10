import 'package:flutter/foundation.dart';

class ResumeProvider extends ChangeNotifier {
  // ========== Personal Information ==========
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phoneNumber = '';
  String _linkedin = '';
  String _github = '';

  // ========== Education ==========
  final List<Map<String, dynamic>> _educationList = [];

  // ========== Work History ==========
  final List<Map<String, dynamic>> _workHistory = [];

  // ========== Skills ==========
  List<String> _skills = [];

  // ========== Projects ==========
  List<Map<String, String>> _projects = [];

  // ========== Certificates ==========
  final List<Map<String, dynamic>> _certificates = [];

  // ========== Languages ==========
  List<String> _languages = [];

  // ========== Achievements & Summary ==========
  String _achievements = '';
  String _professionalSummary = '';
  String _selectedTemplate = '';

  // ----------------------------------------
  // GETTERS
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get linkedin => _linkedin;
  String get github => _github;

  List<Map<String, dynamic>> get educationList => _educationList;
  List<Map<String, dynamic>> get workHistory => _workHistory;
  List<String> get skills => _skills;
  List<Map<String, String>> get projects => _projects;
  List<Map<String, dynamic>> get certificates => _certificates;
  List<String> get languages => _languages;

  String get achievements => _achievements;
  String get professionalSummary => _professionalSummary;
  String get selectedTemplate => _selectedTemplate;

  // ----------------------------------------
  // SETTERS
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

  void addEducation({
    required String degree,
    required String course,
    required String institution,
    required String graduationYear,
    String? cgpa,
  }) {
    _educationList.add({
      'degree': degree,
      
      'institution': institution,
      'start_date': '2022',
      'end_date': graduationYear,
      'cgpa': double.tryParse(cgpa ?? '0') ?? 0,
    });
    notifyListeners();
  }

  void addWorkExperience(Map<String, dynamic> experience) {
    _workHistory.add(experience);
    notifyListeners();
  }

  void clearWorkHistory() {
    _workHistory.clear();
    notifyListeners();
  }

  void updateSkills(List<String> updatedSkills) {
    _skills = updatedSkills;
    notifyListeners();
  }

  void addProject({required String title, required String description}) {
    _projects.add({'name': title, 'description': description});
    notifyListeners();
  }

  void addCertificate({required String title, required String year}) {
    _certificates.add({
      'name': title, 'year': int.tryParse(year)
    });
    notifyListeners();
  }

  void updateLanguages(List<String> langs) {
    _languages = langs;
    notifyListeners();
  }

  void updateAchievements(String value) {
    _achievements = value;
    notifyListeners();
  }

  void updateProfessionalSummary(String value) {
    _professionalSummary = value;
    notifyListeners();
  }

  void updateSelectedTemplate(String template) {
    _selectedTemplate = template;
    notifyListeners();
  }
}
