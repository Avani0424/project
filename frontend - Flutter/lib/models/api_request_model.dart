// resume_model.dart

class Resume {
  final String name;
  final Contact contact;
  final String summary;
  final List<Experience> experience;
  final List<Project> projects;
  final List<Education> education;
  final List<String> skills;
  final List<Certification> certifications;
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
      contact: Contact.fromJson(json['contact']),
      summary: json['summary'],
      experience: (json['experience'] as List).map((e) => Experience.fromJson(e)).toList(),
      projects: (json['projects'] as List).map((e) => Project.fromJson(e)).toList(),
      education: (json['education'] as List).map((e) => Education.fromJson(e)).toList(),
      skills: List<String>.from(json['skills'] ?? []),
      certifications: (json['certifications'] as List).map((e) => Certification.fromJson(e)).toList(),
      languages: List<String>.from(json['languages'] ?? []),
    );
  }
}

class Contact {
  final String email;
  final String phone;
  final String? linkedin;
  final String? github;

  Contact({required this.email, required this.phone, this.linkedin, this.github});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      email: json['email'],
      phone: json['phone'],
      linkedin: json['linkedin'],
      github: json['github'],
    );
  }
}

class Experience {
  final String company;
  final String position;
  final String startDate;
  final String? endDate;
  final List<String> responsibilities;

  Experience({
    required this.company,
    required this.position,
    required this.startDate,
    this.endDate,
    required this.responsibilities,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      company: json['company'],
      position: json['position'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      responsibilities: List<String>.from(json['responsibilities']),
    );
  }
}

class Project {
  final String name;
  final String description;

  Project({required this.name, required this.description});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'],
      description: json['description'],
    );
  }
}

class Education {
  final String institution;
  final String degree;
  final String startDate;
  final String endDate;
  final double? cgpa;

  Education({
    required this.institution,
    required this.degree,
    required this.startDate,
    required this.endDate,
    this.cgpa,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      institution: json['institution'],
      degree: json['degree'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      cgpa: (json['cgpa'] != null) ? json['cgpa'].toDouble() : null,
    );
  }
}

class Certification {
  final String name;
  final int year;

  Certification({required this.name, required this.year});

  factory Certification.fromJson(Map<String, dynamic> json) {
    return Certification(
      name: json['name'],
      year: json['year'],
    );
  }

  extension ResumeJson on Resume {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'contact': contact.toJson(),
      'summary': summary,
      'experience': experience.map((e) => e.toJson()).toList(),
      'projects': projects.map((p) => p.toJson()).toList(),
      'education': education.map((e) => e.toJson()).toList(),
      'skills': skills,
      'certifications': certifications.map((c) => c.toJson()).toList(),
      'languages': languages,
    };
  }
}

extension ContactJson on Contact {
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'linkedin': linkedin,
      'github': github,
    };
  }
}

extension ExperienceJson on Experience {
  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'position': position,
      'start_date': startDate,
      'end_date': endDate,
      'responsibilities': responsibilities,
    };
  }
}

extension ProjectJson on Project {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}

extension EducationJson on Education {
  Map<String, dynamic> toJson() {
    return {
      'institution': institution,
      'degree': degree,
      'start_date': startDate,
      'end_date': endDate,
      'cgpa': cgpa,
    };
  }
}

extension CertificationJson on Certification {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'year': year,
    };
  }
}
}
