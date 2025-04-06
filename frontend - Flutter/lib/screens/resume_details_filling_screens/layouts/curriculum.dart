import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Curriculum extends StatefulWidget {
  const Curriculum({Key? key}) : super(key: key);

  @override
  _CurriculumState createState() => _CurriculumState();
}

class _CurriculumState extends State<Curriculum> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _publicationDateController =
      TextEditingController();
  final List<TextEditingController> _authorControllers = [
    TextEditingController()
  ];
  final double _spacing = 16.0;
  String? _selectedPublicationType;

  @override
  void dispose() {
    _publicationDateController.dispose();
    for (var controller in _authorControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addAuthorField() {
    setState(() {
      _authorControllers.add(TextEditingController());
    });
  }

  Future<void> _selectPublicationDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      setState(() {
        _publicationDateController.text =
            DateFormat('MMMM yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double fieldPadding = MediaQuery.of(context).size.width * 0.05;

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
          'Publications',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(fieldPadding),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: "Tell us about your publications"),
                SizedBox(height: _spacing),
                const CustomTextField(label: 'Title of Publication'),
                SizedBox(height: _spacing),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Publication Type',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                  ),
                  items: [
                    'Journal',
                    'Conference Paper',
                    'Research Paper',
                    'Blog',
                    'Book Chapter',
                    'Whitepaper'
                  ]
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPublicationType = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a publication type' : null,
                ),
                SizedBox(height: _spacing),
                const SectionTitle(title: "Authors"),
                ..._authorControllers.asMap().entries.map((entry) {
                  int index = entry.key;
                  return Column(
                    children: [
                      CustomTextField(
                        label: 'Author ${index + 1}',
                        controller: entry.value,
                      ),
                      SizedBox(height: _spacing),
                    ],
                  );
                }).toList(),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _addAuthorField,
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('Add More',
                        style: TextStyle(color: Colors.white)),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.purple.shade900,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ),
                SizedBox(height: _spacing),
                const CustomTextField(label: 'Publication Name'),
                SizedBox(height: _spacing),
                GestureDetector(
                  onTap: () => _selectPublicationDate(context),
                  child: AbsorbPointer(
                    child: CustomTextField(
                      label: 'Publication Date (Month & Year)',
                      controller: _publicationDateController,
                    ),
                  ),
                ),
                SizedBox(height: _spacing),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Process the data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NextPage()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade900,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                        vertical: 12.0,
                      ),
                    ),
                    child: const Text('Next',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

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

  const CustomTextField({Key? key, required this.label, this.controller})
      : super(key: key);

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
  const NextPage({Key? key}) : super(key: key);

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
