import 'package:flutter/material.dart';
import 'package:miniproject/screens/resume_details_filling_screens/selectscreen.dart';
import 'package:provider/provider.dart';
import '../../resume_provider.dart';

class TemplateSelectionPage extends StatelessWidget {
  const TemplateSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final resumeProvider = Provider.of<ResumeProvider>(context);
    final List<String> templates = [
      'assets/images/template1.jpg',
      'assets/images/template2.jpg',
    ];

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAD9CD0),
        title: Text(
          'Select Resume Template',
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.05,
          ),
        ),
        centerTitle: true, // Centers the title
      
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical, // Vertical scrolling
        itemCount: templates.length,
        itemBuilder: (context, index) {
          final template = templates[index];
          return GestureDetector(
            onTap: () {
              resumeProvider.updateSelectedTemplate(template);
              _showSelectionDialog(context);
            },
            child: Center(
              child: Container(
                width: screenWidth * 0.9, // 90% of screen width
                height: screenHeight * 0.75, // 75% of screen height
                decoration: BoxDecoration(
                  border: Border.all(
                    color: resumeProvider.selectedTemplate == template
                        ? Colors.blue
                        : Colors.transparent,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    template,
                    fit: BoxFit.contain, // Ensures the full image is visible
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Function to show a confirmation dialog when a template is selected
  void _showSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Good Selection!"),
          content: const Text("Would you like to proceed to the next section?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Stay on the same page
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
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
              child: const Text("Yes, Proceed"),
            ),
          ],
        );
      },
    );
  }
}
