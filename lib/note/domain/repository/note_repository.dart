import 'package:flutter_application_drag_and_drop/note/domain/entities/note.dart';

abstract class NoteRepository {
  Future<List<NoteEntity>> getNoteByStatus(String status);
  Future<NoteEntity?> getNoteById(int id);

  Future<void> insertNote(NoteEntity note);
  Future<void> updateNote(NoteEntity note);
  Future<void> deleteNote(NoteEntity note);
}