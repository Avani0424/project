// resume_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'resume_model.dart';

class ResumeApiService {
  const String baseUrl = 'http://10.0.2.2:8000';

  ResumeApiService();

  Future<Resume> postResume(Resume resume) async {
    final response = await http.post(
      Uri.parse('$baseUrl/resume'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(resume.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonBody = json.decode(response.body);
      return Resume.fromJson(jsonBody);
    } else {
      throw Exception('Failed to post resume');
    }
  }
}

