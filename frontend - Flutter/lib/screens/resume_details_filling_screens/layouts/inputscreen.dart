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
                      // Simple email validation
                      final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: 'Age',
                    initialValue: resumeProvider.age,
                    onChanged: (value) => resumeProvider.updateAge(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
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
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: 'City',
                    initialValue: resumeProvider.city,
                    onChanged: (value) => resumeProvider.updateCity(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextField(
                    label: 'Country',
                    initialValue: resumeProvider.country,
                    onChanged: (value) => resumeProvider.updateCountry(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your country';
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

  const CustomTextField({
    Key? key,
    required this.label,
    this.initialValue,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
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
