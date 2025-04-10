import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/skills.dart';
import 'package:miniproject/resume_provider.dart';

class ProfessionalSummaryPage extends StatefulWidget {
  const ProfessionalSummaryPage({super.key});

  @override
  State<ProfessionalSummaryPage> createState() => _ProfessionalSummaryPageState();
}


class _ProfessionalSummaryPageState extends State<ProfessionalSummaryPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the current professional summary from the provider
    final resumeProvider = Provider.of<ResumeProvider>(context, listen: false);
    _controller = TextEditingController(text: resumeProvider.professionalSummary);
  }

  @override
  void dispose() {
    // Dispose the controller to free up resources
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate padding and font size based on screen width
    final double fieldPadding = MediaQuery.of(context).size.width * 0.05;
    final double fieldFontSize = MediaQuery.of(context).size.width * 0.04;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAD9CD0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Professional Summary',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(fieldPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Briefly summarize your professional background",
              style: TextStyle(
                fontSize: fieldFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: fieldPadding),
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "A concise, 3–5 sentence paragraph that highlights your key skills, experience, and career achievements.",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
      
                  ),
                  fillColor: const Color(0xFFFDECEF),
                  filled: true,
                ),
                onChanged: (value) {
                  // Update the professional summary in the provider whenever the text changes
                  Provider.of<ResumeProvider>(context, listen: false)
                      .updateProfessionalSummary(value);
                 
                },
              ),
            ),
            SizedBox(height: fieldPadding),
            SizedBox(height: fieldPadding),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.trim().isEmpty) {
                    // Show a snackbar if the text field is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please provide your professional summary')),
                    );
                  } else {
                    // Navigate to the Skills page with a fade transition
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const Skills(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          var fadeAnimation = animation.drive(Tween(begin: 0.0, end: 1.0));
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
                  backgroundColor: const Color(0xFF4B0082),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
         
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: fieldPadding * 2,
                    vertical: fieldPadding,
                  
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}