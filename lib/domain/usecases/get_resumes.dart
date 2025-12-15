import '../repositories/resume_repository.dart';
import '../entities/resume.dart';

class GetResumes {
  final ResumeRepository repository;

  GetResumes(this.repository);

  Future<List<Resume>> call(String userId) {
    return repository.getResumes(userId);
  }
}
