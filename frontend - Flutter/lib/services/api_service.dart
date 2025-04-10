// resume_api_service.dart

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniproject/screens/loading_screen/loading_screen.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class ResumeApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';
  final BuildContext context;

  ResumeApiService(this.context);

  Future<dynamic> postResume(dynamic resume) async {
    LoadingOverlay().show(context);

    final response = await http.post(
      Uri.parse('$baseUrl/complete-resume'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(resume),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.statusCode == 200) {
        // Get the bytes of the file
        Uint8List bytes = response.bodyBytes;

        // Get directory to save file
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/downloaded_resume.pdf');

        await file.writeAsBytes(bytes);

        print('PDF saved to ${file.path}');

        // Optionally open the file
        OpenFilex.open(file.path);
      } else {
        throw Exception('Failed to post resume');
      }
    }
  }
}
