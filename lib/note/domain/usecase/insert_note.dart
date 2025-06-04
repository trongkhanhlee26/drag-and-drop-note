import 'package:flutter_application_drag_and_drop/core/usecase/usecase.dart';
import 'package:flutter_application_drag_and_drop/note/domain/entities/note.dart';
import 'package:flutter_application_drag_and_drop/note/domain/repository/note_repository.dart';

class InsertNoteUseCase implements UseCase<void, NoteEntity>{
  final NoteRepository _noteRepository;

  InsertNoteUseCase(this._noteRepository);
  
  @override
  Future<void> call({NoteEntity ? params}) async {
    return _noteRepository.insertNote(params!);
  }

  
}