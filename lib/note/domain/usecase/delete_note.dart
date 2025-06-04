import 'package:flutter_application_drag_and_drop/core/usecase/usecase.dart';
import 'package:flutter_application_drag_and_drop/note/domain/entities/note.dart';
import 'package:flutter_application_drag_and_drop/note/domain/repository/note_repository.dart';

class DeleteNoteUseCase implements UseCase<void, NoteEntity>{
  final NoteRepository _noteRepository;

  DeleteNoteUseCase(this._noteRepository);

  @override
  Future<void> call({NoteEntity? params}) async {
    return await _noteRepository.deleteNote(params!);
  }
}