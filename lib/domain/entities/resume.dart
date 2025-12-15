// Domain entity for Resume
class Resume {
  final String id;
  final String userId;
  final String title;
  final PersonalInfo personalInfo;
  final List<WorkExperience> workExperience;
  final List<Education> education;
  final List<String> skills;
  final List<Project> projects;
  final List<Certification> certifications;
  final List<CustomSection> customSections;
  final Template template;
  final Customization customization;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Resume({
    required this.id,
    required this.userId,
    required this.title,
    required this.personalInfo,
    required this.workExperience,
    required this.education,
    required this.skills,
    required this.projects,
    required this.certifications,
    required this.customSections,
    required this.template,
    required this.customization,
    required this.createdAt,
    required this.updatedAt,
  });

  Resume copyWith({
    String? id,
    String? userId,
    String? title,
    PersonalInfo? personalInfo,
    List<WorkExperience>? workExperience,
    List<Education>? education,
    List<String>? skills,
    List<Project>? projects,
    List<Certification>? certifications,
    List<CustomSection>? customSections,
    Template? template,
    Customization? customization,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Resume(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      personalInfo: personalInfo ?? this.personalInfo,
      workExperience: workExperience ?? this.workExperience,
      education: education ?? this.education,
      skills: skills ?? this.skills,
      projects: projects ?? this.projects,
      certifications: certifications ?? this.certifications,
      customSections: customSections ?? this.customSections,
      template: template ?? this.template,
      customization: customization ?? this.customization,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// Supporting entities
class PersonalInfo {
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String? profilePhotoUrl;
  final String? linkedin;
  final String? github;
  final String? website;
  final String? summary;

  const PersonalInfo({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    this.profilePhotoUrl,
    this.linkedin,
    this.github,
    this.website,
    this.summary,
  });
}

class WorkExperience {
  final String id;
  final String jobTitle;
  final String company;
  final String location;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrent;
  final String description;

  const WorkExperience({
    required this.id,
    required this.jobTitle,
    required this.company,
    required this.location,
    required this.startDate,
    this.endDate,
    this.isCurrent = false,
    required this.description,
  });
}

class Education {
  final String id;
  final String degree;
  final String institution;
  final String location;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrent;
  final String? gpa;
  final String? description;

  const Education({
    required this.id,
    required this.degree,
    required this.institution,
    required this.location,
    required this.startDate,
    this.endDate,
    this.isCurrent = false,
    this.gpa,
    this.description,
  });
}

class Project {
  final String id;
  final String name;
  final String description;
  final List<String> technologies;
  final String? url;
  final DateTime? startDate;
  final DateTime? endDate;

  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.technologies,
    this.url,
    this.startDate,
    this.endDate,
  });
}

class Certification {
  final String id;
  final String name;
  final String issuer;
  final DateTime issueDate;
  final DateTime? expiryDate;
  final String? credentialId;
  final String? url;

  const Certification({
    required this.id,
    required this.name,
    required this.issuer,
    required this.issueDate,
    this.expiryDate,
    this.credentialId,
    this.url,
  });
}

class CustomSection {
  final String id;
  final String title;
  final String content;

  const CustomSection({
    required this.id,
    required this.title,
    required this.content,
  });
}

class Template {
  final String id;
  final String name;
  final String category;
  final Map<String, dynamic> metadata; // font, spacing, layout

  const Template({
    required this.id,
    required this.name,
    required this.category,
    required this.metadata,
  });
}

class Customization {
  final String fontFamily;
  final double fontSize;
  final String colorTheme;
  final double spacing;
  final double margin;

  const Customization({
    required this.fontFamily,
    required this.fontSize,
    required this.colorTheme,
    required this.spacing,
    required this.margin,
  });
}
