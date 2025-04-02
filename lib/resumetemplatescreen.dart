import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'resume_provider.dart';

class ResumeTemplateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Resume Template"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Choose a template for your resume:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: templateList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Provider.of<ResumeProvider>(context, listen: false)
                          .updateSelectedTemplate(templateList[index]);
                      Navigator.pop(context); // Go back to the previous screen
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.description,
                              size: 50, color: Colors.purple),
                          SizedBox(height: 10),
                          Text(templateList[index]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy template names (replace with actual previews if available)
List<String> templateList = ["Classic", "Modern", "Professional", "Minimalist"];
