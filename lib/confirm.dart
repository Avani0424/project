import 'package:flutter/material.dart';
import 'package:miniproject/login.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'package:miniproject/resume_provider.dart'; // Import your ResumeProvider

class Confirm extends StatelessWidget {
  const Confirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7ECEC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Image.asset(
                'assets/images/password.png',
                height: screenHeight * 0.35, // Adjusted dynamically
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Confirm Your Details',
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Consumer<ResumeProvider>(
                builder: (context, resumeProvider, child) {
                  return Column(
                    children: [
                      _buildInfoRow('First Name', resumeProvider.firstName),
                      _buildInfoRow('Last Name', resumeProvider.lastName),
                      _buildInfoRow('Email', resumeProvider.email),
                      _buildInfoRow('Age', resumeProvider.age),
                      _buildInfoRow('Phone Number', resumeProvider.phoneNumber),
                      _buildInfoRow('City', resumeProvider.city),
                      _buildInfoRow('Country', resumeProvider.country),
                      _buildInfoRow(
                          'Achievements', resumeProvider.achievements),
                      SizedBox(height: screenHeight * 0.04),
                      ElevatedButton(
                        onPressed: () {
                          // Add logic for saving data here, or navigating to login
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      Login(), // Navigate to Login screen
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.1,
                            vertical: screenHeight * 0.02,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.05),
                          ),
                        ),
                        child: Text(
                          'Confirm & Save',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }

  // Helper function to display a row of information
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty
                  ? 'Not Provided'
                  : value, // Display 'Not Provided' if value is empty
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
