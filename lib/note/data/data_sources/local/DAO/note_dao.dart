import 'package:floor/floor.dart';
import 'package:flutter_application_drag_and_drop/note/data/models/note.dart';

@dao
abstract class NoteDao {

  @Insert()
  Future<void> insertNote(NoteModels note);

  @update
  Future<void> updateNote(NoteModels note);

  @delete
  Future<void> deleteNote(NoteModels note);

  @Query('SELECT * FROM note WHERE status = :status')
  Future<List<NoteModels>> getNoteByStatus(String status);

  @Query('SELECT * FROM note WHERE id = :id')
  Future<NoteModels?> getNoteById(int id);
}