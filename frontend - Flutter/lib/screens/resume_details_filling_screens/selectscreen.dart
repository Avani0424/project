import 'package:flutter/material.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/curriculum.dart';

import 'package:miniproject/screens/resume_details_filling_screens/layouts/inputscreen.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/acheivements.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/skills.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/workdetails.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/certificate.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/language.dart';
import 'package:miniproject/screens/template_selection_screen/templateselectionpage.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/education.dart';
import 'package:provider/provider.dart';
import 'package:miniproject/resume_provider.dart';

class Selectscreen extends StatelessWidget {
  const Selectscreen({super.key});

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
                    const TemplateSelectionPage(),
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
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: screenWidth * 0.04,
                mainAxisSpacing: screenHeight * 0.02,
                childAspectRatio: 1.0,
                children: [
                  SectionBox(
                    title: "Personal Details",
                    imagePath: "assets/images/person.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactInformationPage()),
                      );
                    },
                  ),
                  SectionBox(
                    title: "Qualification",
                    imagePath: "assets/images/qualification.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Education()),
                      );
                    },
                  ),
                  SectionBox(
                    title: "Work History",
                    imagePath: "assets/images/works.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Workdetails()),
                      );
                    },
                  ),
                  SectionBox(
                    title: "Summary",
                    imagePath: "assets/images/achievement.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfessionalSummaryPage()),
                      );
                    },
                  ),
                  SectionBox(
                    title: "Skills",
                    imagePath: "assets/images/skill.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Skills()),
                      );
                    },
                  ),
                  SectionBox(
                    title: "Project",
                    imagePath: "assets/images/curriculum.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProjectPage()),
                      );
                    },
                  ),
                  SectionBox(
                    title: "Certificate",
                    imagePath: "assets/images/certificate.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CertificatePage()),
                      );
                    },
                  ),
                  SectionBox(
                    title: "Language",
                    imagePath: "assets/images/language.png",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LanguagePage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Generate PDF Button
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
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
                  generatePDF(context);
                },
                icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                label: Text(
                  "Generate PDF",
                  style: TextStyle(
                      fontSize: screenWidth * 0.045, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
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

  void generatePDF(BuildContext context) {
    final resumeData = Provider.of<ResumeProvider>(context, listen: false);

    print("Generating PDF with:");
    print("Name: ${resumeData.firstName} ${resumeData.lastName}");
    print("Email: ${resumeData.email}");
    print("Phone: ${resumeData.phoneNumber}");
    print("LinkedIn: ${resumeData.linkedin}");
    print("GitHub: ${resumeData.github}");
    print("Achievements: ${resumeData.achievements}");
    print("Summary: ${resumeData.professionalSummary}");
    print("Template: ${resumeData.selectedTemplate}");

    // TODO: Replace this print block with actual PDF generation logic
  }
}

class SectionBox extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const SectionBox({super.key, 
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
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
          children: [
            Image.asset(
              imagePath,
              width: screenWidth * 0.18,
              height: screenWidth * 0.18,
            ),
            const SizedBox(height: 8),
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
