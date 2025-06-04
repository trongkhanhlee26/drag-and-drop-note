// widgets/note_column.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_drag_and_drop/note/domain/entities/note.dart';
import 'package:get/get.dart';

class NoteTable extends StatelessWidget {
  final String title;
  final List<NoteEntity> notes;
  final void Function(NoteEntity) onNoteDropped;

  const NoteTable({
    super.key,
    required this.title,
    required this.notes,
    required this.onNoteDropped,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DragTarget<NoteEntity>(
        onAcceptWithDetails: (details) => onNoteDropped(details.data),
        builder: (context, candidateData, rejectedData) => Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final note = notes[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Draggable<NoteEntity>(
                              data: note,
                              feedback: Material(
                                color: Colors.transparent,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(note.title ?? '', style: const TextStyle(fontSize: 16),),                                                                  
                                  ),
                                ),
                              ),
                              childWhenDragging: Opacity(
                                opacity: 0.5,
                                child: Card(child: ListTile(title: Text(note.title ?? ''))),
                              ),
                              child: Card(child: ListTile(title: Text(note.title ?? '', overflow: TextOverflow.ellipsis, maxLines: 1),
                              onTap: () {
                                Get.toNamed('/note_detail', arguments: note.id);
                              },
                              )),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
  Widget buildNoteColumn({
      required String title,
      required List<NoteEntity> notes,
      required void Function(NoteEntity) onNoteDropped,
    }) {
    return NoteTable(
      title: title,
      notes: notes,
      onNoteDropped: onNoteDropped,
    );
  }
