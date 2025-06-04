import 'package:flutter_application_drag_and_drop/core/usecase/usecase.dart';
import 'package:flutter_application_drag_and_drop/note/domain/entities/note.dart';
import 'package:flutter_application_drag_and_drop/note/domain/repository/note_repository.dart';

class GetNoteByStatusUseCase implements UseCase<List<NoteEntity>, String>{
  final NoteRepository _noteRepository;

  GetNoteByStatusUseCase(this._noteRepository);

  @override
  Future<List<NoteEntity>> call({String? params}) async {
    return await _noteRepository.getNoteByStatus(params!); 
  }
}