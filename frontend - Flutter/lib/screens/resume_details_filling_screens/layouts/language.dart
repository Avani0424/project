import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:miniproject/resume_provider.dart';
import 'package:miniproject/screens/resume_details_filling_screens/selectscreen.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _languageController = TextEditingController();
  String _selectedProficiency = 'Fluent';

  List<Map<String, String>> languages = [];

  void _addLanguage() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        languages.add({
          'language': _languageController.text.trim(),
          'proficiency': _selectedProficiency,
        });
        _languageController.clear();
        _selectedProficiency = 'Fluent';
      });
    }
  }

  void _removeLanguage(int index) {
    setState(() {
      languages.removeAt(index);
    });
  }

  void _saveToProvider() {
    final resumeProvider = Provider.of<ResumeProvider>(context, listen: false);
    final List<String> langList = languages
        .map((lang) => '${lang['language']} (${lang['proficiency']})')
        .toList();
    resumeProvider.updateLanguages(langList);

    // Debug print
    print("Saved Languages: $langList");
  }

  @override
  void dispose() {
    _languageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fieldPadding = 16.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Languages"),
        backgroundColor: const Color(0xFFAD9CD0),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _languageController,
                      decoration: const InputDecoration(labelText: 'Language'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter a language' : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: DropdownButtonFormField<String>(
                      value: _selectedProficiency,
                      items: ['Native', 'Fluent', 'Intermediate', 'Basic']
                          .map((level) => DropdownMenuItem(
                                value: level,
                                child: Text(level),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedProficiency = value!;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Proficiency'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.green, size: 30),
                    onPressed: _addLanguage,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: languages.isEmpty
                  ? const Center(child: Text("No languages added"))
                  : ListView.builder(
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        final lang = languages[index];
                        return Card(
                          child: ListTile(
                            title: Text(lang['language']!),
                            subtitle:
                                Text("Proficiency: ${lang['proficiency']}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () => _removeLanguage(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  if (languages.isNotEmpty) {
                    _saveToProvider();
                    Navigator.pushReplacement(
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
    );
  }
}
