import 'package:flutter/material.dart';
import 'package:miniproject/resume_provider.dart';
import 'package:provider/provider.dart';
import 'package:miniproject/screens/resume_details_filling_screens/selectscreen.dart';
import 'package:miniproject/screens/resume_details_filling_screens/layouts/acheivements.dart';

class Workdetails extends StatefulWidget {
  const Workdetails({super.key});

  @override
  State<Workdetails> createState() => _WorkdetailsState();
}

class _WorkdetailsState extends State<Workdetails> {
  final _formKey = GlobalKey<FormState>();
  List<WorkExperienceForm> workExperienceForms = [WorkExperienceForm()];

  void _addWorkExperience() {
    setState(() {
      workExperienceForms.add(WorkExperienceForm());
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final provider = Provider.of<ResumeProvider>(context, listen: false);
      provider.clearWorkHistory(); // Clear previous entries (optional)

      for (var form in workExperienceForms) {
        provider.addWorkExperience({
          'jobTitle': form.jobTitleController.text,
          'company': form.companyController.text,
          'location': form.locationController.text,
          'startDate': form.startDateController.text,
          'endDate': form.endDateController.text,
          'responsibilities': form.responsibilitiesController.text
              .split('\n')
              .where((line) => line.trim().isNotEmpty)
              .toList(), // Bullet points
        });
      }

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ProfessionalSummaryPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween(begin: 0.0, end: 1.0);
            var fadeAnimation = animation.drive(tween);
            return FadeTransition(opacity: fadeAnimation, child: child);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.05;
    double verticalPadding = screenHeight * 0.02;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAD9CD0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                  return FadeTransition(opacity: fadeAnimation, child: child);
                },
              ),
            );
          },
        ),
        title:
            const Text('Work Details', style: TextStyle(color: Colors.black)),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(horizontalPadding),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ...workExperienceForms,
                SizedBox(height: verticalPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _addWorkExperience,
                      icon: const Icon(Icons.add),
                      label: const Text("Add More"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[900],
                      ),
                      child: const Text("Next",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WorkExperienceForm extends StatefulWidget {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController responsibilitiesController =
      TextEditingController();

  WorkExperienceForm({super.key});

  @override
  _WorkExperienceFormState createState() => _WorkExperienceFormState();
}

class _WorkExperienceFormState extends State<WorkExperienceForm> {
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    double verticalPadding = MediaQuery.of(context).size.height * 0.015;

    return Padding(
      padding: EdgeInsets.only(bottom: verticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(label: 'Job Title', controller: widget.jobTitleController),
          SizedBox(height: verticalPadding),
          CustomTextField(label: 'Company Name', controller: widget.companyController),
          SizedBox(height: verticalPadding),
          CustomTextField(label: 'Location (City, State)', controller: widget.locationController),
          SizedBox(height: verticalPadding),
          GestureDetector(
            onTap: () => _selectDate(context, widget.startDateController),
            child: AbsorbPointer(
              child: TextFormField(
                controller: widget.startDateController,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a start date';
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(height: verticalPadding),
          GestureDetector(
            onTap: () => _selectDate(context, widget.endDateController),
            child: AbsorbPointer(
              child: TextFormField(
                controller: widget.endDateController,
                decoration: InputDecoration(
                  labelText: 'End Date',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an end date';
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(height: verticalPadding),
          TextFormField(
            controller: widget.responsibilitiesController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Key Responsibilities',
              hintText: "Add bullet points (each on a new line)",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter key responsibilities';
              }
              return null;
            },
          ),
          const Divider(thickness: 1),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }
}
