class Resume {
  final String name;
  final Map<String, dynamic> contact;
  final String summary;
  final List<Map<String, dynamic>> experience;
  final List<Map<String, dynamic>> projects;
  final List<Map<String, dynamic>> education;
  final List<String> skills;
  final List<Map<String, dynamic>> certifications;
  final List<String> languages;

  Resume({
    required this.name,
    required this.contact,
    required this.summary,
    required this.experience,
    required this.projects,
    required this.education,
    required this.skills,
    required this.certifications,
    required this.languages,
  });

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      name: json['name'],
      contact: Map<String, dynamic>.from(json['contact']),
      summary: json['summary'],
      experience: List<Map<String, dynamic>>.from(json['experience']),
      projects: List<Map<String, dynamic>>.from(json['projects']),
      education: List<Map<String, dynamic>>.from(json['education']),
      skills: List<String>.from(json['skills'] ?? []),
      certifications: List<Map<String, dynamic>>.from(json['certifications']),
      languages: List<String>.from(json['languages'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'contact': contact,
      'summary': summary,
      'experience': experience,
      'projects': projects,
      'education': education,
      'skills': skills,
      'certifications': certifications,
      'languages': languages,
    };
  }
}
