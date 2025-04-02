import 'package:http/http.dart' as http;

class ApiService {
  Future<void> submitResume({
    required String firstName,
    required String lastName,
    required String email,
    required String age,
    required String phoneNumber,
    required String city,
    required String country,
    required String achievements,
  }) async {
    final url = Uri.parse(
        'http://10.0.2.2:8000/submit_resume/'); // Use PC's IP for a real device

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: '''
      {
        "first_name": "$firstName",
        "last_name": "$lastName",
        "email": "$email",
        "age": "$age",
        "phone_number": "$phoneNumber",
        "city": "$city",
        "country": "$country",
        "achievements": "$achievements"
      }
      ''',
    );

    if (response.statusCode == 200) {
      print("✅ Resume submitted successfully!");
      print("Response: ${response.body}");
    } else {
      print("❌ Error: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  }
}
