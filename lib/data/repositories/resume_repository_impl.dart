import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/resume_repository.dart';
import '../../domain/entities/resume.dart';
import '../models/resume_model.dart';

class ResumeRepositoryImpl implements ResumeRepository {
  final FirebaseFirestore _firestore;

  ResumeRepositoryImpl(this._firestore);

  @override
  Future<List<Resume>> getResumes(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('resumes')
          .where('userId', isEqualTo: userId)
          .orderBy('updatedAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => ResumeModel.fromFirestore(doc).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Failed to get resumes: $e');
    }
  }

  @override
  Future<Resume?> getResume(String resumeId) async {
    try {
      final doc = await _firestore.collection('resumes').doc(resumeId).get();
      if (doc.exists) {
        return ResumeModel.fromFirestore(doc).toEntity();
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get resume: $e');
    }
  }

  @override
  Future<Resume> createResume(Resume resume) async {
    try {
      final resumeModel = ResumeModel.fromEntity(resume);
      final docRef = await _firestore
          .collection('resumes')
          .add(resumeModel.toFirestore());
      final createdResume = resume.copyWith(id: docRef.id);
      return createdResume;
    } catch (e) {
      throw Exception('Failed to create resume: $e');
    }
  }

  @override
  Future<Resume> updateResume(Resume resume) async {
    try {
      final resumeModel = ResumeModel.fromEntity(resume);
      await _firestore
          .collection('resumes')
          .doc(resume.id)
          .update(resumeModel.toFirestore());
      return resume;
    } catch (e) {
      throw Exception('Failed to update resume: $e');
    }
  }

  @override
  Future<void> deleteResume(String resumeId) async {
    try {
      await _firestore.collection('resumes').doc(resumeId).delete();
    } catch (e) {
      throw Exception('Failed to delete resume: $e');
    }
  }

  @override
  Future<Resume> duplicateResume(String resumeId) async {
    try {
      final originalResume = await getResume(resumeId);
      if (originalResume == null) {
        throw Exception('Resume not found');
      }

      final duplicatedResume = originalResume.copyWith(
        id: '', // Will be set by Firestore
        title: '${originalResume.title} (Copy)',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      return await createResume(duplicatedResume);
    } catch (e) {
      throw Exception('Failed to duplicate resume: $e');
    }
  }
}
