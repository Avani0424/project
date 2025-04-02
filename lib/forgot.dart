import 'package:flutter/material.dart';
import 'package:miniproject/otppage.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _LoginState();
}

class _LoginState extends State<Forgot> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF7ECEC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Image.asset(
                'assets/images/forgot.png',
                height: isSmallScreen ? screenHeight * 0.3 : screenHeight * 0.4,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: isSmallScreen ? 24 : 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomInputField(
                      controller: _usernameController,
                      icon: Icons.person,
                      hintText: 'Username',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      OTPPage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = 0.0;
                                var end = 1.0;
                                var tween = Tween(begin: begin, end: end);
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
                        backgroundColor: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: screenHeight * 0.02,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Send',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 16 : 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
          ],
        ),
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomInputField({
    Key? key,
    required this.icon,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.03,
        ),
      ),
      validator: validator,
    );
  }
}
