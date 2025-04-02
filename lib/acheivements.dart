import 'package:flutter/material.dart';
import 'package:miniproject/skills.dart';
import 'package:provider/provider.dart';
import 'resume_provider.dart'; // Import the ResumeProvider

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({Key? key}) : super(key: key);

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  late TextEditingController _achievementsController;

  @override
  void initState() {
    super.initState();
    final resumeProvider = Provider.of<ResumeProvider>(context, listen: false);
    _achievementsController =
        TextEditingController(text: resumeProvider.achievements);
  }

  @override
  void dispose() {
    _achievementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAD9CD0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title:
            const Text('Achievements', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Briefly summarize your professional achievements",
              style: TextStyle(
                  fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "Get help writing your bullet points.",
              style: TextStyle(
                  fontSize: screenWidth * 0.04, color: Colors.black54),
            ),
            SizedBox(height: screenHeight * 0.03),
            TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
                fillColor: const Color(0xFFFDECEF),
                filled: true,
              ),
              controller: _achievementsController,
              onChanged: (value) {
                Provider.of<ResumeProvider>(context, listen: false)
                    .updateAchievements(value);
              },
            ),
            SizedBox(height: screenHeight * 0.03),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  final achievements =
                      Provider.of<ResumeProvider>(context, listen: false)
                          .achievements;
                  if (achievements.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Please provide your achievements')),
                    );
                  } else {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Skills(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                              opacity: animation, child: child);
                        },
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B0082),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08,
                    vertical: screenHeight * 0.015,
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white, fontSize: screenWidth * 0.04),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
