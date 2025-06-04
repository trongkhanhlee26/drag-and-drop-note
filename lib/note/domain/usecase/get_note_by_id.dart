import 'package:flutter_application_drag_and_drop/core/usecase/usecase.dart';
import 'package:flutter_application_drag_and_drop/note/domain/entities/note.dart';
import 'package:flutter_application_drag_and_drop/note/domain/repository/note_repository.dart';

class GetNoteByIdUseCase implements UseCase<NoteEntity?, int>{
  final NoteRepository _noteRepository;

  GetNoteByIdUseCase(this._noteRepository);

  @override
  Future<NoteEntity?> call({int ? params}) async {
    return await _noteRepository.getNoteById(params!);
  }
}