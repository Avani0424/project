import 'package:flutter/material.dart';
import 'package:miniproject/homescreen.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 234, 196, 235),
              Color.fromARGB(255, 114, 37, 196),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: screenHeight * 0.2,
              width: screenWidth * 0.4,
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'RESUMIFY',
              style: TextStyle(
                fontSize: screenWidth * 0.08,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              'Your AI-powered Resume Builder',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Homescreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
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
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                  vertical: screenHeight * 0.025,
                ),
              ),
              child: Text(
                'GET STARTED',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: Color(0xFF6A11CB),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
