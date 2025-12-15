import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/resume_provider.dart';
import '../../domain/entities/resume.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final resumesAsync = ref.watch(resumesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Resumes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context, ref),
          ),
        ],
      ),
      body: resumesAsync.when(
        data: (resumes) => _buildResumesList(context, resumes, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Failed to load resumes'),
              ElevatedButton(
                onPressed: () => ref.invalidate(resumesProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewResume(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildResumesList(
    BuildContext context,
    List<Resume> resumes,
    WidgetRef ref,
  ) {
    if (resumes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.description, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'No resumes yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Create your first professional resume',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _createNewResume(context),
              icon: const Icon(Icons.add),
              label: const Text('Create Resume'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: resumes.length,
      itemBuilder: (context, index) {
        final resume = resumes[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(resume.title),
            subtitle: Text(
              'Updated ${resume.updatedAt.toLocal().toString().split(' ')[0]}',
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) =>
                  _handleResumeAction(context, value, resume, ref),
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(
                  value: 'duplicate',
                  child: Text('Duplicate'),
                ),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
            onTap: () => _editResume(context, resume),
          ),
        );
      },
    );
  }

  void _createNewResume(BuildContext context) {
    // TODO: Navigate to resume builder
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resume builder coming soon!')),
    );
  }

  void _editResume(BuildContext context, Resume resume) {
    // TODO: Navigate to resume builder with existing resume
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Editing ${resume.title}')));
  }

  void _handleResumeAction(
    BuildContext context,
    String action,
    Resume resume,
    WidgetRef ref,
  ) {
    switch (action) {
      case 'edit':
        _editResume(context, resume);
        break;
      case 'duplicate':
        _duplicateResume(context, resume, ref);
        break;
      case 'delete':
        _deleteResume(context, resume, ref);
        break;
    }
  }

  void _duplicateResume(BuildContext context, Resume resume, WidgetRef ref) {
    // TODO: Implement duplicate functionality
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Duplicating ${resume.title}')));
  }

  void _deleteResume(BuildContext context, Resume resume, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Resume'),
        content: Text('Are you sure you want to delete "${resume.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement delete functionality
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${resume.title} deleted')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(authNotifierProvider.notifier).signOut();
              Navigator.of(context).pop();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
