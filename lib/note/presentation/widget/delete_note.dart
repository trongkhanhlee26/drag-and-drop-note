// lib/note/presentation/widgets/delete_note_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_drag_and_drop/note/domain/entities/note.dart';
import 'package:flutter_application_drag_and_drop/note/presentation/controller/note_controller.dart';
import 'package:get/get.dart';

class DeleteNote extends StatelessWidget {
  final NoteEntity note;
  const DeleteNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NoteController>();
    return IconButton(
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
    );
  }
}
