import 'package:flutter/material.dart';
import 'package:miniproject/screens/resume_details_filling_screens/selectscreen.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/workdetails.dart';

class Education extends StatefulWidget {
  const Education({Key? key}) : super(key: key);

  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  void dispose() {
    _collegeController.dispose();
    _degreeController.dispose();
    _branchController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                    Selectscreen(),
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
          },
        ),
        title: Text(
          'Educational Qualification',
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.045,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tell us about your education",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              CustomTextField(
                label: 'College Name',
                controller: _collegeController,
                fontSize: screenWidth * 0.04,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your college name';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.015),
              CustomTextField(
                label: 'Degree',
                controller: _degreeController,
                fontSize: screenWidth * 0.04,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your degree';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.015),
              CustomTextField(
                label: 'Branch',
                controller: _branchController,
                fontSize: screenWidth * 0.04,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your branch';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.015),
              GestureDetector(
                onTap: () => _selectDate(context, _startDateController),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _startDateController,
                    decoration: InputDecoration(
                      labelText: 'Graduation Start Date',
                      labelStyle: TextStyle(fontSize: screenWidth * 0.04),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.015,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a start date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              GestureDetector(
                onTap: () => _selectDate(context, _endDateController),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _endDateController,
                    decoration: InputDecoration(
                      labelText: 'Graduation End Date',
                      labelStyle: TextStyle(fontSize: screenWidth * 0.04),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.015,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an end date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Workdetails(),
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
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.02,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                    ],
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

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final double fontSize;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.fontSize,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: fontSize),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(fontSize * 0.4),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: fontSize * 1.5,
          vertical: fontSize * 0.8,
        ),
      ),
      validator: validator,
    );
  }
}
