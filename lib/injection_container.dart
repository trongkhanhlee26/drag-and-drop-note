import 'package:flutter_application_drag_and_drop/note/data/data_sources/local/DAO/app_database.dart';
import 'package:flutter_application_drag_and_drop/note/data/repository/note_repository_impl.dart';
import 'package:flutter_application_drag_and_drop/note/domain/repository/note_repository.dart';
import 'package:flutter_application_drag_and_drop/note/domain/usecase/delete_note.dart';
import 'package:flutter_application_drag_and_drop/note/domain/usecase/get_note_by_id.dart';
import 'package:flutter_application_drag_and_drop/note/domain/usecase/get_note_by_status.dart';
import 'package:flutter_application_drag_and_drop/note/domain/usecase/insert_note.dart';
import 'package:flutter_application_drag_and_drop/note/domain/usecase/update_note.dart';
import 'package:flutter_application_drag_and_drop/note/presentation/controller/note_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:event_bus/event_bus.dart';
final getIt = GetIt.instance;

final EventBus eventBus = EventBus();

Future<void> initializeDependencies() async {
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  getIt.registerSingleton<AppDatabase>(database);
  getIt.registerSingleton<EventBus>(eventBus);
  getIt.registerSingleton<NoteRepository>(NoteRepositoryImpl(getIt()));
  getIt.registerSingleton<DeleteNoteUseCase>(DeleteNoteUseCase(getIt()));
  getIt.registerSingleton<GetNoteByStatusUseCase>(GetNoteByStatusUseCase(getIt()));
  getIt.registerSingleton<InsertNoteUseCase>(InsertNoteUseCase(getIt()));
  getIt.registerSingleton<UpdateNoteUseCase>(UpdateNoteUseCase(getIt()));
  getIt.registerSingleton<GetNoteByIdUseCase>(GetNoteByIdUseCase(getIt()));
  getIt.registerSingleton<NoteController>(NoteController(
    getIt<InsertNoteUseCase>(),
    getIt<DeleteNoteUseCase>(),
    getIt<GetNoteByIdUseCase>(),
    getNoteByStatus: getIt<GetNoteByStatusUseCase>(),
    updateNoteUseCase: getIt<UpdateNoteUseCase>(),
  ));
  
}