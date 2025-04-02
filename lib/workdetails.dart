import 'package:flutter/material.dart';
import 'package:miniproject/acheivements.dart';
import 'package:miniproject/selectscreen.dart';

class Workdetails extends StatefulWidget {
  const Workdetails({Key? key}) : super(key: key);

  @override
  _WorkdetailsState createState() => _WorkdetailsState();
}

class _WorkdetailsState extends State<Workdetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  String? _selectedYearOfExperience;

  List<String> yearsOfExperience =
      List.generate(51, (index) => (index + 1).toString());

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        controller.text = "${picked.toLocal()}"
            .split(' ')[0]; // Format the date as yyyy-mm-dd
      });
    }
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.05;
    double verticalPadding = screenHeight * 0.02;
    double buttonWidth = screenWidth * 0.3;
    double buttonPaddingVertical = screenHeight * 0.015;

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
        title: const Text(
          'Work Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(horizontalPadding),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tell us about your work Experience",
                  style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: verticalPadding),
                const CustomTextField(label: 'Job Title'),
                SizedBox(height: verticalPadding),
                const CustomTextField(label: 'Firm Details'),
                SizedBox(height: verticalPadding),
                DropdownButtonFormField<String>(
                  value: _selectedYearOfExperience,
                  hint: const Text("Select Year of Experience"),
                  items: yearsOfExperience.map((year) {
                    return DropdownMenuItem(value: year, child: Text(year));
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedYearOfExperience = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a year of experience';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Year of Experience',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                  ),
                ),
                SizedBox(height: verticalPadding),
                GestureDetector(
                  onTap: () => _selectDate(context, _startDateController),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _startDateController,
                      decoration: InputDecoration(
                        labelText: 'Start date',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
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
                  onTap: () => _selectDate(context, _endDateController),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _endDateController,
                      decoration: InputDecoration(
                        labelText: 'End date',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const AchievementsPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var tween = Tween(begin: 0.0, end: 1.0);
                              var fadeAnimation = animation.drive(tween);
                              return FadeTransition(
                                  opacity: fadeAnimation, child: child);
                            },
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(
                        horizontal: buttonWidth * 0.2,
                        vertical: buttonPaddingVertical,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Next', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 10),
                      ],
                    ),
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

class CustomTextField extends StatelessWidget {
  final String label;

  const CustomTextField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
