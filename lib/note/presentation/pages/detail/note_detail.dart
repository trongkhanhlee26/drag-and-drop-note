import 'package:flutter/material.dart';
import 'package:flutter_application_drag_and_drop/note/domain/entities/note.dart';
import 'package:flutter_application_drag_and_drop/note/presentation/controller/note_controller.dart';
import 'package:flutter_application_drag_and_drop/note/presentation/widget/delete_note.dart';
import 'package:flutter_application_drag_and_drop/note/presentation/widget/update_note.dart';
import 'package:get/get.dart';

class NoteDetailPage extends StatelessWidget {
  const NoteDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int? noteId = Get.arguments as int?;
    final NoteController controller = Get.find<NoteController>();

    return FutureBuilder<NoteEntity?>(
      future: controller.getNoteById(noteId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Note Detail'),
              leading: BackButton(),
            ),
            body: const Center(child: Text('Note not found')),
          );
        }
        final note = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Note Detail'),
            leading: BackButton(),
            actions: [
              UpdateNote(note: note),
              DeleteNote(note: note),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(note.title ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text(note.content ?? '', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 24),
                Opacity(opacity: 0.5, child: Text('Created: ${note.createdAt}')),
                Opacity(opacity: 0.5, child: Text('Updated: ${note.updatedAt}')),
              ],
            ),
          ),
        );
      },
    );
  }
}