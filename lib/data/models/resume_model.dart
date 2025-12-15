import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/resume.dart';

// Data model for Firestore operations
class ResumeModel {
  final String id;
  final String userId;
  final String title;
  final Map<String, dynamic> personalInfo;
  final List<Map<String, dynamic>> workExperience;
  final List<Map<String, dynamic>> education;
  final List<String> skills;
  final List<Map<String, dynamic>> projects;
  final List<Map<String, dynamic>> certifications;
  final List<Map<String, dynamic>> customSections;
  final Map<String, dynamic> template;
  final Map<String, dynamic> customization;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ResumeModel({
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

  // Convert from Firestore document
  factory ResumeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ResumeModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      title: data['title'] ?? '',
      personalInfo: data['personalInfo'] ?? {},
      workExperience: List<Map<String, dynamic>>.from(
        data['workExperience'] ?? [],
      ),
      education: List<Map<String, dynamic>>.from(data['education'] ?? []),
      skills: List<String>.from(data['skills'] ?? []),
      projects: List<Map<String, dynamic>>.from(data['projects'] ?? []),
      certifications: List<Map<String, dynamic>>.from(
        data['certifications'] ?? [],
      ),
      customSections: List<Map<String, dynamic>>.from(
        data['customSections'] ?? [],
      ),
      template: data['template'] ?? {},
      customization: data['customization'] ?? {},
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Convert to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'title': title,
      'personalInfo': personalInfo,
      'workExperience': workExperience,
      'education': education,
      'skills': skills,
      'projects': projects,
      'certifications': certifications,
      'customSections': customSections,
      'template': template,
      'customization': customization,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Convert to domain entity
  Resume toEntity() {
    return Resume(
      id: id,
      userId: userId,
      title: title,
      personalInfo: PersonalInfo(
        fullName: personalInfo['fullName'] ?? '',
        email: personalInfo['email'] ?? '',
        phone: personalInfo['phone'] ?? '',
        address: personalInfo['address'] ?? '',
        profilePhotoUrl: personalInfo['profilePhotoUrl'],
        linkedin: personalInfo['linkedin'],
        github: personalInfo['github'],
        website: personalInfo['website'],
        summary: personalInfo['summary'],
      ),
      workExperience: workExperience
          .map(
            (e) => WorkExperience(
              id: e['id'] ?? '',
              jobTitle: e['jobTitle'] ?? '',
              company: e['company'] ?? '',
              location: e['location'] ?? '',
              startDate: (e['startDate'] as Timestamp).toDate(),
              endDate: e['endDate'] != null
                  ? (e['endDate'] as Timestamp).toDate()
                  : null,
              isCurrent: e['isCurrent'] ?? false,
              description: e['description'] ?? '',
            ),
          )
          .toList(),
      education: education
          .map(
            (e) => Education(
              id: e['id'] ?? '',
              degree: e['degree'] ?? '',
              institution: e['institution'] ?? '',
              location: e['location'] ?? '',
              startDate: (e['startDate'] as Timestamp).toDate(),
              endDate: e['endDate'] != null
                  ? (e['endDate'] as Timestamp).toDate()
                  : null,
              isCurrent: e['isCurrent'] ?? false,
              gpa: e['gpa'],
              description: e['description'],
            ),
          )
          .toList(),
      skills: skills,
      projects: projects
          .map(
            (e) => Project(
              id: e['id'] ?? '',
              name: e['name'] ?? '',
              description: e['description'] ?? '',
              technologies: List<String>.from(e['technologies'] ?? []),
              url: e['url'],
              startDate: e['startDate'] != null
                  ? (e['startDate'] as Timestamp).toDate()
                  : null,
              endDate: e['endDate'] != null
                  ? (e['endDate'] as Timestamp).toDate()
                  : null,
            ),
          )
          .toList(),
      certifications: certifications
          .map(
            (e) => Certification(
              id: e['id'] ?? '',
              name: e['name'] ?? '',
              issuer: e['issuer'] ?? '',
              issueDate: (e['issueDate'] as Timestamp).toDate(),
              expiryDate: e['expiryDate'] != null
                  ? (e['expiryDate'] as Timestamp).toDate()
                  : null,
              credentialId: e['credentialId'],
              url: e['url'],
            ),
          )
          .toList(),
      customSections: customSections
          .map(
            (e) => CustomSection(
              id: e['id'] ?? '',
              title: e['title'] ?? '',
              content: e['content'] ?? '',
            ),
          )
          .toList(),
      template: Template(
        id: template['id'] ?? '',
        name: template['name'] ?? '',
        category: template['category'] ?? '',
        metadata: template['metadata'] ?? {},
      ),
      customization: Customization(
        fontFamily: customization['fontFamily'] ?? 'Roboto',
        fontSize: customization['fontSize'] ?? 12.0,
        colorTheme: customization['colorTheme'] ?? 'blue',
        spacing: customization['spacing'] ?? 8.0,
        margin: customization['margin'] ?? 16.0,
      ),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // Create from domain entity
  factory ResumeModel.fromEntity(Resume resume) {
    return ResumeModel(
      id: resume.id,
      userId: resume.userId,
      title: resume.title,
      personalInfo: {
        'fullName': resume.personalInfo.fullName,
        'email': resume.personalInfo.email,
        'phone': resume.personalInfo.phone,
        'address': resume.personalInfo.address,
        'profilePhotoUrl': resume.personalInfo.profilePhotoUrl,
        'linkedin': resume.personalInfo.linkedin,
        'github': resume.personalInfo.github,
        'website': resume.personalInfo.website,
        'summary': resume.personalInfo.summary,
      },
      workExperience: resume.workExperience
          .map(
            (e) => {
              'id': e.id,
              'jobTitle': e.jobTitle,
              'company': e.company,
              'location': e.location,
              'startDate': Timestamp.fromDate(e.startDate),
              'endDate': e.endDate != null
                  ? Timestamp.fromDate(e.endDate!)
                  : null,
              'isCurrent': e.isCurrent,
              'description': e.description,
            },
          )
          .toList(),
      education: resume.education
          .map(
            (e) => {
              'id': e.id,
              'degree': e.degree,
              'institution': e.institution,
              'location': e.location,
              'startDate': Timestamp.fromDate(e.startDate),
              'endDate': e.endDate != null
                  ? Timestamp.fromDate(e.endDate!)
                  : null,
              'isCurrent': e.isCurrent,
              'gpa': e.gpa,
              'description': e.description,
            },
          )
          .toList(),
      skills: resume.skills,
      projects: resume.projects
          .map(
            (e) => {
              'id': e.id,
              'name': e.name,
              'description': e.description,
              'technologies': e.technologies,
              'url': e.url,
              'startDate': e.startDate != null
                  ? Timestamp.fromDate(e.startDate!)
                  : null,
              'endDate': e.endDate != null
                  ? Timestamp.fromDate(e.endDate!)
                  : null,
            },
          )
          .toList(),
      certifications: resume.certifications
          .map(
            (e) => {
              'id': e.id,
              'name': e.name,
              'issuer': e.issuer,
              'issueDate': Timestamp.fromDate(e.issueDate),
              'expiryDate': e.expiryDate != null
                  ? Timestamp.fromDate(e.expiryDate!)
                  : null,
              'credentialId': e.credentialId,
              'url': e.url,
            },
          )
          .toList(),
      customSections: resume.customSections
          .map((e) => {'id': e.id, 'title': e.title, 'content': e.content})
          .toList(),
      template: {
        'id': resume.template.id,
        'name': resume.template.name,
        'category': resume.template.category,
        'metadata': resume.template.metadata,
      },
      customization: {
        'fontFamily': resume.customization.fontFamily,
        'fontSize': resume.customization.fontSize,
        'colorTheme': resume.customization.colorTheme,
        'spacing': resume.customization.spacing,
        'margin': resume.customization.margin,
      },
      createdAt: resume.createdAt,
      updatedAt: resume.updatedAt,
    );
  }
}
