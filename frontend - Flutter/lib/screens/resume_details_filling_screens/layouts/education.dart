import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:miniproject/resume_provider.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/workdetails.dart';
import 'package:miniproject/screens/resume_details_filling_screens/selectscreen.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDegree;
  String? _selectedCourse;
  final TextEditingController _collegeController = TextEditingController();
  String? _selectedGraduationYear;
  final TextEditingController _cgpaController = TextEditingController();

  final List<String> _degrees = [
    'Bachelor of Technology',
    'Bachelor of Science',
    'Bachelor of Arts',
    'Master of Technology',
    'Master of Science',
    'Master of Arts',
    'Doctor of Philosophy',
  ];

  final List<String> _courses = [
    'Computer Science',
    'Information Technology',
    'Electronics and Communication',
    'Mechanical Engineering',
    'Civil Engineering',
    'Electrical Engineering',
  ];

  final List<String> _graduationYears = List<String>.generate(
    50,
    (index) => (DateTime.now().year - index).toString(),
  );

  @override
  void dispose() {
    _collegeController.dispose();
    _cgpaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double fieldPadding = MediaQuery.of(context).size.width * 0.05;
    final double fieldFontSize = MediaQuery.of(context).size.width * 0.04;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAD9CD0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                     const Selectscreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var tween = Tween(begin: 0.0, end: 1.0);
                  var fadeAnimation = animation.drive(tween);
                  return FadeTransition(opacity: fadeAnimation, child: child);
                },
              ),
            );
          },
        ),
        title: const Text(
          'Educational Qualification',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(fieldPadding),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "Tell us about your education",
                style: TextStyle(
                  fontSize: fieldFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: fieldPadding),
              DropdownButtonFormField<String>(
                value: _selectedDegree,
                decoration: InputDecoration(
                  labelText: 'Degree Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: fieldPadding,
                    vertical: fieldPadding * 0.75,
                  ),
                ),
                items: _degrees
                    .map((degree) => DropdownMenuItem<String>(
                          value: degree,
                          child: Text(degree),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDegree = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select your degree' : null,
              ),
              SizedBox(height: fieldPadding),
              DropdownButtonFormField<String>(
                value: _selectedDegree,
                decoration: InputDecoration(
                  labelText: 'Degree Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: fieldPadding,
                    vertical: fieldPadding * 0.75,
                  ),
                ),
                items: _degrees
                    .map((degree) => DropdownMenuItem<String>(
                          value: degree,
                          child: Text(degree),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDegree = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select your degree' : null,
              ),
              SizedBox(height: fieldPadding),
              DropdownButtonFormField<String>(
                value: _selectedCourse,
                decoration: InputDecoration(
                  labelText: 'Course',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: fieldPadding,
                    vertical: fieldPadding * 0.75,
                  ),
                ),
                items: _courses
                    .map((course) => DropdownMenuItem<String>(
                          value: course,
                          child: Text(course),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCourse = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select your course' : null,
              ),
              SizedBox(height: fieldPadding),
              TextFormField(
                controller: _collegeController,
                decoration: InputDecoration(
                  labelText: 'College/University Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: fieldPadding,
                    vertical: fieldPadding * 0.75,
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your college/university name'
                    : null,
              ),
              SizedBox(height: fieldPadding),
              DropdownButtonFormField<String>(
                value: _selectedGraduationYear,
                decoration: InputDecoration(
                  labelText: 'Graduation Year',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: fieldPadding,
                    vertical: fieldPadding * 0.75,
                  ),
                ),
                items: _graduationYears
                    .map((year) => DropdownMenuItem<String>(
                          value: year,
                          child: Text(year),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGraduationYear = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select your graduation year' : null,
              ),
              SizedBox(height: fieldPadding),
              TextFormField(
                controller: _cgpaController,
                decoration: InputDecoration(
                  labelText: 'CGPA (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: fieldPadding,
                    vertical: fieldPadding * 0.75,
                  ),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final cgpa = double.tryParse(value);
                    if (cgpa == null || cgpa < 0 || cgpa > 10) {
                      return 'Please enter a valid CGPA (0–10)';
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: fieldPadding * 2),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final provider = Provider.of<ResumeProvider>(
                        context,
                        listen: false,
                      );

                      provider.addEducation(
                        degree: _selectedDegree!,
                        course: _selectedCourse!,
                        institution: _collegeController.text,
                        graduationYear: _selectedGraduationYear!,
                        cgpa: _cgpaController.text,
                      );

                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const Workdetails(),
                            
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var tween = Tween(begin: 0.0, end: 1.0);
                            var fadeAnimation = animation.drive(tween);
                            return FadeTransition(
                              opacity: fadeAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
              
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: fieldPadding * 2,
                      vertical: fieldPadding * 0.8,
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
