import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/certificate.dart';
import 'package:miniproject/resume_provider.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  List<Map<String, TextEditingController>> projectControllers = [];

  @override
  void initState() {
    super.initState();
    addProjectSection();
  }

  void addProjectSection() {
    setState(() {
      projectControllers.add({
        'title': TextEditingController(),
        'description': TextEditingController(),
        'responsibilities': TextEditingController(),
      });
    });
  }

  @override
  void dispose() {
    for (var project in projectControllers) {
      project['title']!.dispose();
      project['description']!.dispose();
      project['responsibilities']!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fieldPadding = 16.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ...projectControllers.asMap().entries.map((entry) {
                    int index = entry.key;
                    var project = entry.value;

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: project['title'],
                              decoration: const InputDecoration(
                                labelText: 'Project Title',
                                hintText: 'e.g., Resume Builder App',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: project['description'],
                              maxLines: 3,
                              decoration: const InputDecoration(
                                labelText: 'Project Description',
                                hintText: 'Brief summary of the project',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: project['responsibilities'],
                              maxLines: 3,
                              decoration: const InputDecoration(
                                labelText: 'Responsibilities',
                                hintText: 'e.g., Developed backend, integrated API',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: addProjectSection,
                      icon: const Icon(Icons.add),
                      label: const Text(
                        'Add Project',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  final resumeProvider = Provider.of<ResumeProvider>(context, listen: false);

                  final projects = projectControllers.map((project) {
                    return {
                      'title': project['title']!.text.trim(),
                      'description': project['description']!.text.trim(),
                      'responsibilities': project['responsibilities']!.text.trim(),
                    };
                  }).where((proj) => proj['title']!.isNotEmpty).toList();

                  resumeProvider.updateProjects(projects);

                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const CertificatePage(),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: fieldPadding * 2,
                    vertical: fieldPadding * 0.8,
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

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).size.width * 0.05;
    return Text(
      title,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;

  const CustomTextField({super.key, required this.label, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? '$label is required' : null,
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
      body: const Center(
        child: Text('This is the next page.'),
      ),
    );
  }
}
