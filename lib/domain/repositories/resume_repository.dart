import '../entities/resume.dart';

// Abstract repository interface for Resume operations
abstract class ResumeRepository {
  // Get all resumes for a user
  Future<List<Resume>> getResumes(String userId);

  // Get a specific resume by ID
  Future<Resume?> getResume(String resumeId);

  // Create a new resume
  Future<Resume> createResume(Resume resume);

  // Update an existing resume
  Future<Resume> updateResume(Resume resume);

  // Delete a resume
  Future<void> deleteResume(String resumeId);

  // Duplicate a resume
  Future<Resume> duplicateResume(String resumeId);
}
