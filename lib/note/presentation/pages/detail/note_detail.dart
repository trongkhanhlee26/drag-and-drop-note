import 'package:flutter/material.dart';
import 'package:flutter_application_drag_and_drop/note/domain/entities/note.dart';
import 'package:flutter_application_drag_and_drop/note/presentation/controller/note_controller.dart';
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
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final result = await showDialog<Map<String, String>>(
                    context: context,
                    builder: (context) {
                      final titleController = TextEditingController(text: note.title);
                      final contentController = TextEditingController(text: note.content);
                      return AlertDialog(
                        title: const Text('Edit Note'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: titleController,
                              decoration: const InputDecoration(labelText: 'Title'),
                            ),
                            TextField(
                              controller: contentController,
                              decoration: const InputDecoration(labelText: 'Content'),
                              maxLines: 3,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, {
                                'title': titleController.text,
                                'content': contentController.text,
                              });
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      );
                    },
                  );
                  if (result != null) {
                    final updatedNote = note.copyWith(
                      title: result['title'],
                      content: result['content'],
                      updatedAt: DateTime.now(),
                    );
                    await controller.updateNote(params: updatedNote);
                    Get.back();
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Note'),
                      content: const Text('Are you sure you want to delete this note?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await controller.deleteNote(note);
                    Get.back();
                  }
                },
              ),
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