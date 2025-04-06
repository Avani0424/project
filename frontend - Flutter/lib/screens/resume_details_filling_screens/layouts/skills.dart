import 'package:flutter/material.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/curriculum.dart';
import 'package:miniproject/screens/resume_details_filling_screens/selectscreen.dart';

class Skills extends StatefulWidget {
  const Skills({Key? key}) : super(key: key);

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  final _formKey = GlobalKey<FormState>();

  // Controllers and FocusNodes for Technical Skills
  final List<TextEditingController> _technicalSkillControllers = [];
  final List<FocusNode> _technicalSkillFocusNodes = [];

  // Controllers and FocusNodes for Soft Skills
  final List<TextEditingController> _softSkillControllers = [];
  final List<FocusNode> _softSkillFocusNodes = [];

  @override
  void dispose() {
    // Dispose all controllers and focus nodes
    for (var controller in _technicalSkillControllers) {
      controller.dispose();
    }
    for (var focusNode in _technicalSkillFocusNodes) {
      focusNode.dispose();
    }
    for (var controller in _softSkillControllers) {
      controller.dispose();
    }
    for (var focusNode in _softSkillFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _addTechnicalSkillField() {
    setState(() {
      _technicalSkillControllers.add(TextEditingController());
      _technicalSkillFocusNodes.add(FocusNode());
    });
  }

  void _removeTechnicalSkillField(int index) {
    setState(() {
      _technicalSkillControllers[index].dispose();
      _technicalSkillFocusNodes[index].dispose();
      _technicalSkillControllers.removeAt(index);
      _technicalSkillFocusNodes.removeAt(index);
    });
  }

  void _addSoftSkillField() {
    setState(() {
      _softSkillControllers.add(TextEditingController());
      _softSkillFocusNodes.add(FocusNode());
    });
  }

  void _removeSoftSkillField(int index) {
    setState(() {
      _softSkillControllers[index].dispose();
      _softSkillFocusNodes[index].dispose();
      _softSkillControllers.removeAt(index);
      _softSkillFocusNodes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skills'),
        backgroundColor: const Color(0xFFAD9CD0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Technical Skills Section
              const Text(
                "Technical Skills",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ..._buildSkillFields(
                _technicalSkillControllers,
                _technicalSkillFocusNodes,
                _removeTechnicalSkillField,
              ),
              TextButton.icon(
                onPressed: _addTechnicalSkillField,
                icon: const Icon(Icons.add),
                label: const Text('Add Technical Skill'),
              ),
              const SizedBox(height: 20),

              // Soft Skills Section
              const Text(
                "Soft Skills",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ..._buildSkillFields(
                _softSkillControllers,
                _softSkillFocusNodes,
                _removeSoftSkillField,
              ),
              TextButton.icon(
                onPressed: _addSoftSkillField,
                icon: const Icon(Icons.add),
                label: const Text('Add Soft Skill'),
              ),
              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Process the entered skills
                    List<String> technicalSkills = _technicalSkillControllers
                        .map((controller) => controller.text.trim())
                        .where((text) => text.isNotEmpty)
                        .toList();
                    List<String> softSkills = _softSkillControllers
                        .map((controller) => controller.text.trim())
                        .where((text) => text.isNotEmpty)
                        .toList();

                    // Navigate to the next screen or perform desired action
                    // For example:
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => NextScreen(
                    //       technicalSkills: technicalSkills,
                    //       softSkills: softSkills,
                    //     ),
                    //   ),
                    // );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B0082),
                ),
                child:
                    const Text('Next', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSkillFields(
    List<TextEditingController> controllers,
    List<FocusNode> focusNodes,
    Function(int) removeField,
  ) {
    return List.generate(controllers.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: 'Enter skill',
                  filled: true,
                  fillColor: const Color(0xFFFDECEF),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a skill';
                  }
                  return null;
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () => removeField(index),
            ),
          ],
        ),
      );
    });
  }
}
