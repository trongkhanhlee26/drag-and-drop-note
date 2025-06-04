// lib/note/presentation/widgets/update_note_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_drag_and_drop/note/domain/entities/note.dart';
import 'package:flutter_application_drag_and_drop/note/presentation/controller/note_controller.dart';
import 'package:get/get.dart';

class UpdateNote extends StatelessWidget {
  final NoteEntity note;
  const UpdateNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NoteController>();
    return IconButton(
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
          await controller.updateNote(note, result['title'] ?? '', result['content'] ?? '',);
          Get.back();
        }
      },
    );
  }
}
