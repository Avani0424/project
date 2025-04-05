import 'package:flutter/material.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/education.dart';
import 'package:miniproject/screens/resume_details_filling_screens/selectscreen.dart';
import '../../../resume_provider.dart';
import 'package:provider/provider.dart';

class Inputscreen extends StatelessWidget {
  const Inputscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ContactInformationPage();
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
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
          },
        ),
        title: const Text('Personal Details',
            style: TextStyle(color: Colors.black)),
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
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  CustomTextField(
                    label: 'First Name',
                    initialValue: resumeProvider.firstName,
                    onChanged: resumeProvider.updateFirstName,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your first name'
                        : null,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: 'Last Name',
                    initialValue: resumeProvider.lastName,
                    onChanged: resumeProvider.updateLastName,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your last name'
                        : null,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: 'Email',
                    initialValue: resumeProvider.email,
                    onChanged: resumeProvider.updateEmail,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter your email';
                      final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      return !regex.hasMatch(value)
                          ? 'Please enter a valid email'
                          : null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: 'Mobile No',
                    initialValue: resumeProvider.phoneNumber,
                    onChanged: resumeProvider.updatePhoneNumber,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your mobile number'
                        : null,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: 'LinkedIn URL',
                    initialValue: resumeProvider.linkedin,
                    onChanged: resumeProvider.updateLinkedin,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter your LinkedIn URL';
                      final regex = RegExp(
                          r'^(https?://)?([\w.-]+)\.([a-z]{2,6})([\/\w\.-]*)*\/?$');
                      return !regex.hasMatch(value)
                          ? 'Please enter a valid URL'
                          : null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: 'GitHub URL (Optional)',
                    initialValue: resumeProvider.github,
                    onChanged: resumeProvider.updateGithub,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final regex = RegExp(
                            r'^(https?://)?([\w.-]+)\.([a-z]{2,6})([\/\w\.-]*)*\/?$');
                        return !regex.hasMatch(value)
                            ? 'Please enter a valid URL'
                            : null;
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
                                return FadeTransition(
                                    opacity: animation, child: child);
                              },
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                          vertical: screenHeight * 0.02,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Next', style: TextStyle(color: Colors.white)),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
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
  final TextInputType? keyboardType;

  const CustomTextField({
    Key? key,
    required this.label,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: screenWidth < 600 ? 14 : 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: screenWidth * 0.02,
        ),
      ),
    );
  }
}
