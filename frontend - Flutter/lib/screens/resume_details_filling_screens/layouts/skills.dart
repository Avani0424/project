import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:miniproject/resume_provider.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/curriculum.dart';

class Skills extends StatefulWidget {
  const Skills({super.key});

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  List<SkillSection> skillSections = [SkillSection()];
  final _formKey = GlobalKey<FormState>();
  final double fieldPadding = 16.0;

  void addSection() {
    setState(() {
      skillSections.add(SkillSection());
    });
  }

  void removeSection(int index) {
    if (skillSections.length > 1) {
      setState(() {
        skillSections.removeAt(index);
      });
    }
  }

  void addSkill(int sectionIndex) {
    setState(() {
      skillSections[sectionIndex].skills.add(TextEditingController());
    });
  }

  void removeSkill(int sectionIndex, int skillIndex) {
    if (skillSections[sectionIndex].skills.length > 1) {
      setState(() {
        skillSections[sectionIndex].skills.removeAt(skillIndex);
      });
    }
  }

  @override
  void dispose() {
    for (var section in skillSections) {
      section.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skills", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFAD9CD0),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    for (int i = 0; i < skillSections.length; i++) ...[
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: skillSections[i].sectionNameController,
                              decoration: const InputDecoration(
                                hintText: 'e.g. Programming Languages',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removeSection(i),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      for (int j = 0; j < skillSections[i].skills.length; j++)
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: skillSections[i].skills[j],
                                decoration: const InputDecoration(
                                  hintText: 'e.g. Python, Java',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () => removeSkill(i, j),
                            ),
                          ],
                        ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () => addSkill(i),
                          icon: const Icon(Icons.add),
                          label: const Text("Add Skill"),
                        ),
                      ),
                      const Divider(thickness: 1),
                    ],
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: addSection,
                      icon: const Icon(Icons.add),
                      label: const Text("Add New Section"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B0082),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final resumeProvider = Provider.of<ResumeProvider>(context, listen: false);

                      List<String> collectedSkills = [];
                      for (var section in skillSections) {
                        final skills = section.skills
                            .map((controller) => controller.text.trim())
                            .where((skill) => skill.isNotEmpty)
                            .toList();
                        
                          collectedSkills = skills;
                        
                      }

                      resumeProvider.updateSkills(collectedSkills);

                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const ProjectPage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
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
      ),
    );
  }
}

class SkillSection {
  TextEditingController sectionNameController = TextEditingController();
  List<TextEditingController> skills = [TextEditingController()];

  void dispose() {
    sectionNameController.dispose();
    for (var c in skills) {
      c.dispose();
    }
  }
}
