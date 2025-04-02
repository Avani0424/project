import 'package:flutter/material.dart';
import 'package:miniproject/acheivements.dart';
import 'package:miniproject/curriculum.dart';
import 'package:miniproject/education.dart';
import 'package:miniproject/inputscreen.dart';
import 'package:miniproject/skills.dart';
import 'package:miniproject/templateselectionpage.dart';
import 'package:miniproject/workdetails.dart';

class Selectscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                    TemplateSelectionPage(),
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
        title: Text(
          'Resume Sections',
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.050,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: screenWidth * 0.04, // 4% of screen width
                mainAxisSpacing: screenHeight * 0.02, // 2% of screen height
                childAspectRatio: 1.0, // Keeps the aspect ratio square (1:1)
                children: [
                  SectionBox(
                    title: "Personal Details",
                    imagePath: "assets/images/person.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Inputscreen()),
                      );
                    },
                  ),
                  SectionBox(
                    title: "Qualification",
                    imagePath: "assets/images/qualification.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Education()),
                      );
                    },
                  ),
                  SectionBox(
                    title: "Work History",
                    imagePath: "assets/images/works.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Workdetails()),
                      );
                    },
                  ),
                  SectionBox(
                    title: "Achievements",
                    imagePath: "assets/images/achievement.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AchievementsPage()),
                      );
                    },
                  ),
                  SectionBox(
                    title: "Skills",
                    imagePath: "assets/images/skill.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Skills()),
                      );
                    },
                  ),
                  SectionBox(
                    title: "Curriculum Vitae",
                    imagePath: "assets/images/curriculum.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Curriculum()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Generate PDF Button at Bottom
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 234, 196, 235),
                    Color.fromARGB(255, 114, 37, 196),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  generatePDF();
                },
                icon: Icon(Icons.picture_as_pdf, color: Colors.white),
                label: Text(
                  "Generate PDF",
                  style: TextStyle(
                      fontSize: screenWidth * 0.045, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.transparent, // Transparent to show gradient
                  shadowColor: Colors.transparent, // Remove button shadow
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenWidth * 0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void generatePDF() {
    // TODO: Implement PDF generation logic
    print("Generating PDF...");
  }
}

class SectionBox extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const SectionBox(
      {required this.title, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 234, 196, 235),
              Color.fromARGB(255, 114, 37, 196),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: screenWidth * 0.18,
              height: screenWidth * 0.18,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
