import 'package:flutter_application_drag_and_drop/note/domain/entities/note.dart';
import 'package:flutter_application_drag_and_drop/note/domain/usecase/delete_note.dart';
import 'package:flutter_application_drag_and_drop/note/domain/usecase/get_note_by_id.dart';
import 'package:flutter_application_drag_and_drop/note/domain/usecase/get_note_by_status.dart';
import 'package:flutter_application_drag_and_drop/note/domain/usecase/insert_note.dart';
import 'package:flutter_application_drag_and_drop/note/domain/usecase/update_note.dart';
import 'package:get/get.dart';

class NoteController extends GetxController{

  final GetNoteByStatusUseCase getNoteByStatus;
  final UpdateNoteUseCase updateNoteUseCase;
  final InsertNoteUseCase insertNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetNoteByIdUseCase getNoteByIdUseCase;

  NoteController(this.insertNoteUseCase, this.deleteNoteUseCase, this.getNoteByIdUseCase, {required this.getNoteByStatus, required this.updateNoteUseCase});

  final RxList<NoteEntity> toDoNotes = <NoteEntity>[].obs;
  final RxList<NoteEntity> doingNotes = <NoteEntity>[].obs;
  final RxList<NoteEntity> doneNotes = <NoteEntity>[].obs; 

  @override
  void onInit() {
    super.onInit();
      loadNotes();
  }

  Future<void> loadNotes() async {
    try{
    toDoNotes.value = await getNoteByStatus(params: 'to_do');
    doingNotes.value = await getNoteByStatus(params: 'doing');
    doneNotes.value = await getNoteByStatus(params: 'done');
    }
    catch (e) {
      print('Error loading notes: $e');
    }
  }
  Future<NoteEntity?> getNoteById(int id) async {
    return await getNoteByIdUseCase(params: id);
  }
  Future<void> updateNoteStatus(NoteEntity note, String newStatus) async {
    final updatedStatus = note.copyWith(
      status: newStatus
    );
    await getNoteByStatus(params: updatedStatus.status);

    // Xóa khỏi list cũ
    toDoNotes.remove(note);
    doingNotes.remove(note);
    doneNotes.remove(note);

    // Thêm vào list mới
    if (newStatus == 'to_do') toDoNotes.add(updatedStatus);
    if (newStatus == 'doing') doingNotes.add(updatedStatus);
    if (newStatus == 'done') doneNotes.add(updatedStatus);
  }

  Future<void> insertNote({required String title, required String content}) async {
    final now = DateTime.now();
    final newNote = NoteEntity(
      title: title,
      content: content,
      status: 'to_do',
      createdAt: now,
      updatedAt: now,
    );
    await insertNoteUseCase(params: newNote);
    await loadNotes();
  }

  Future<void> deleteNote(NoteEntity note) async {
    await deleteNoteUseCase(params: note);
    await loadNotes();
  }

  Future<void> updateNote(NoteEntity note, String title, String content) async {
    final updatedNote = note.copyWith(
    title: title,
    content: content,
    updatedAt: DateTime.now(),
  );
    await updateNoteUseCase(params: updatedNote);
    await loadNotes();
  }
}