import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:miniproject/resume_provider.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/language.dart';

class CertificatePage extends StatefulWidget {
  const CertificatePage({super.key});

  @override
  _CertificatePageState createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _certificateController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  List<Map<String, String>> certificates = [];

  void _addCertificate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        certificates.add({
          'name': _certificateController.text,
          'year': _yearController.text,
        });
        _certificateController.clear();
        _yearController.clear();
      });
    }
  }

  void _saveToProvider() {
    final resumeProvider = Provider.of<ResumeProvider>(context, listen: false);
    for (var cert in certificates) {
      // You can also store year if needed, but original ResumeProvider only uses a string.
      resumeProvider.addCertificate('${cert['name']} (${cert['year']})');
    }
  }

  @override
  void dispose() {
    _certificateController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Certificates"),
        backgroundColor: const Color(0xFFAD9CD0),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _certificateController,
                    decoration: const InputDecoration(labelText: 'Certificate Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Enter certificate name' : null,
                  ),
                  TextFormField(
                    controller: _yearController,
                    decoration: const InputDecoration(labelText: 'Year'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'Enter year' : null,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addCertificate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Add Certificate'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: certificates.isEmpty
                  ? const Center(child: Text("No certificates added"))
                  : ListView.builder(
                      itemCount: certificates.length,
                      itemBuilder: (context, index) {
                        final cert = certificates[index];
                        return Card(
                          child: ListTile(
                            title: Text(cert['name']!),
                            subtitle: Text("Year: ${cert['year']}"),
                          ),
                        );
                      },
                    ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  _saveToProvider();
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          LanguagePage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        var tween = Tween(begin: 0.0, end: 1.0);
                        return FadeTransition(
                          opacity: animation.drive(tween),
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
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
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
