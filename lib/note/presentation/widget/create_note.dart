import 'package:flutter/material.dart';

class CreateNote extends StatefulWidget {
  final void Function(String title, String content) onCreate;

  const CreateNote({super.key, required this.onCreate});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Note'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final title = _titleController.text.trim();
            final content = _contentController.text.trim();
            if (title.isNotEmpty && content.isNotEmpty) {
              widget.onCreate(title, content);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
