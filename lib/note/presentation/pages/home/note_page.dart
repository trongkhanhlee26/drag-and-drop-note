import 'package:flutter/material.dart';
import 'package:flutter_application_drag_and_drop/note/presentation/controller/note_controller.dart';
import 'package:flutter_application_drag_and_drop/note/presentation/widget/create_note.dart';
import 'package:flutter_application_drag_and_drop/note/presentation/widget/note_table.dart';
import 'package:get/get.dart';

class NotePage extends StatelessWidget {
  NotePage({super.key});

  final NoteController controller = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kanban Notes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CreateNote(
              onCreate: (title, content) {
                controller.insertNote(title: title, content: content);
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () => Row(
          children: [
            buildNoteColumn(
              title: 'To Do',
              notes: controller.toDoNotes.toList(), 
              onNoteDropped: (note) => controller.updateNoteStatus(note, 'to_do'),
            ),
            buildNoteColumn(
              title: 'Doing',
              notes: controller.doingNotes.toList(),
              onNoteDropped: (note) => controller.updateNoteStatus(note, 'doing'),
            ),
            buildNoteColumn(
              title: 'Done',
              notes: controller.doneNotes.toList(),
              onNoteDropped: (note) => controller.updateNoteStatus(note, 'done'),
            ),
          ],
        ),
      ),
    );
  }
}
