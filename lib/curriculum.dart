import 'package:flutter/material.dart';
import 'package:miniproject/selectscreen.dart';

class Curriculum extends StatefulWidget {
  const Curriculum({Key? key}) : super(key: key);

  @override
  _CurriculumState createState() => _CurriculumState();
}

class _CurriculumState extends State<Curriculum> {
  final TextEditingController _activitiesController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _activitiesController.dispose();
    super.dispose();
  }

  // Method to validate form and navigate
  void _onNextPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      // If form is valid, navigate to the next page
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              Selectscreen(), // Go to the next page
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
          'Curriculum',
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
                "Tell us about your extra curricular activities",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Get help writing your bullet points.",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Expanded(
                child: TextFormField(
                  controller: _activitiesController,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    ),
                    fillColor: const Color(0xFFFDECEF),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your extracurricular activities';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: _onNextPressed, // Use the validation method
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B0082),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.015,
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
                      SizedBox(width: screenWidth * 0.01),
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
