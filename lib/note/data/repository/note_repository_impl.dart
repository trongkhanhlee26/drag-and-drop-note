

import 'package:flutter_application_drag_and_drop/note/data/data_sources/local/DAO/app_database.dart';
import 'package:flutter_application_drag_and_drop/note/data/models/note.dart';
import 'package:flutter_application_drag_and_drop/note/domain/entities/note.dart';
import 'package:flutter_application_drag_and_drop/note/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository{
  final AppDatabase _appDatabase;
  NoteRepositoryImpl(this._appDatabase);

  @override
  Future<void> deleteNote(NoteEntity note) async{
    return _appDatabase.noteDao.deleteNote(NoteModels.fromEntity(note));
  }

  @override
  Future<List<NoteEntity>> getNoteByStatus(String status) async {
    final notes = await _appDatabase.noteDao.getNoteByStatus(status);
    return notes.map((noteModel) => noteModel.toEntity()).toList();
  }

  @override
  Future<void> insertNote(NoteEntity note) async{
    await _appDatabase.noteDao.insertNote(NoteModels.fromEntity(note));
  }

  @override
  Future<void> updateNote(NoteEntity note) async{
    await _appDatabase.noteDao.updateNote(NoteModels.fromEntity(note));
  }
  
  @override
  Future<NoteEntity?> getNoteById(int id) async {
    final noteModel = await _appDatabase.noteDao.getNoteById(id);
    if (noteModel == null) return null;
    return noteModel.toEntity();
  }
}