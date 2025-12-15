import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/usecases/get_resumes.dart';
import '../../domain/repositories/resume_repository.dart';
import '../../data/repositories/resume_repository_impl.dart';
import '../../domain/entities/resume.dart';
import 'auth_provider.dart';

// Repository provider
final resumeRepositoryProvider = Provider<ResumeRepository>((ref) {
  return ResumeRepositoryImpl(FirebaseFirestore.instance);
});

// Usecase providers
final getResumesProvider = Provider<GetResumes>((ref) {
  final repository = ref.watch(resumeRepositoryProvider);
  return GetResumes(repository);
});

// Resume list provider
final resumesProvider =
    StateNotifierProvider<ResumesNotifier, AsyncValue<List<Resume>>>((ref) {
  final getResumes = ref.watch(getResumesProvider);
  final currentUser = ref.watch(currentUserProvider);
  return ResumesNotifier(getResumes, currentUser?.uid ?? '');
});

class ResumesNotifier extends StateNotifier<AsyncValue<List<Resume>>> {
  final GetResumes _getResumes;
  final String _userId;

  ResumesNotifier(this._getResumes, this._userId)
      : super(const AsyncValue.loading()) {
    if (_userId.isNotEmpty) {
      loadResumes();
    }
  }

  Future<void> loadResumes() async {
    if (_userId.isEmpty) return;

    state = const AsyncValue.loading();
    try {
      final resumes = await _getResumes(_userId);
      state = AsyncValue.data(resumes);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> refresh() async {
    await loadResumes();
  }
}
