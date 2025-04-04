import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/education.dart';
import 'package:miniproject/screens/resume_details_filling_screens/selectscreen.dart';
import '../../../resume_provider.dart';

class Inputscreen extends StatelessWidget {
  const Inputscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ResumeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const ContactInformationPage(),
      ),
    );
  }
}

class ContactInformationPage extends StatefulWidget {
  const ContactInformationPage({Key? key}) : super(key: key);

  @override
  _ContactInformationPageState createState() => _ContactInformationPageState();
}

class _ContactInformationPageState extends State<ContactInformationPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAD9CD0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Selectscreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var tween = Tween(begin: 0.0, end: 1.0);
                  return FadeTransition(
                    opacity: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );
          },
        ),
        title: const Text(
          'Personal Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Consumer<ResumeProvider>(
          builder: (context, resumeProvider, child) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    "What's the best ways for employers to contact you?",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 18 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  CustomTextField(
                    label: 'First Name',
                    initialValue: resumeProvider.firstName,
                    onChanged: (value) => resumeProvider.updateFirstName(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: 'Last Name',
                    initialValue: resumeProvider.lastName,
                    onChanged: (value) => resumeProvider.updateLastName(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: 'Email',
                    initialValue: resumeProvider.email,
                    onChanged: (value) => resumeProvider.updateEmail(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: 'Mobile No',
                    initialValue: resumeProvider.phoneNumber,
                    onChanged: (value) =>
                        resumeProvider.updatePhoneNumber(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      // You might want to add more specific phone number validation
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: 'LinkedIn URL',
                    initialValue: resumeProvider.linkedin,
                    onChanged: (value) => resumeProvider.updateLinkedin(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your LinkedIn URL';
                      }
                      // Basic URL validation
                      final regex = RegExp(
                          r'^(https?://)?([\w.-]+)\.([a-z]{2,6})([\/\w \.-]*)*\/?$');
                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid URL';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: 'GitHub URL (Optional)',
                    initialValue: resumeProvider.github,
                    onChanged: (value) => resumeProvider.updateGithub(value),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        // Basic URL validation for optional field
                        final regex = RegExp(
                            r'^(https?://)?([\w.-]+)\.([a-z]{2,6})([\/\w \.-]*)*\/?$');
                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid URL';
                        }
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const Education(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var tween = Tween(begin: 0.0, end: 1.0);
                                return FadeTransition(
                                  opacity: animation.drive(tween),
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                          vertical: screenHeight * 0.02,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      height: screenHeight * 0.03), // Added some bottom padding
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType; // Added keyboardType

  const CustomTextField({
    Key? key,
    required this.label,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.keyboardType, // Initialize keyboardType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType, // Use keyboardType if provided
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: screenWidth < 600 ? 14 : 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: screenWidth * 0.02,
        ),
      ),
    );
  }
}
