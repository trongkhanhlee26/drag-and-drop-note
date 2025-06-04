import 'package:flutter_application_drag_and_drop/injection_container.dart';
import 'package:flutter_application_drag_and_drop/note/presentation/controller/note_controller.dart';
import 'package:flutter_application_drag_and_drop/note/presentation/pages/detail/note_detail.dart';
import 'package:flutter_application_drag_and_drop/note/presentation/pages/home/note_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String notePage = '/';
  static const String noteDetail = '/note_detail';

  static final routes = [
    GetPage(
      name: notePage,
      page: () => NotePage(),
      binding: BindingsBuilder(() {
        Get.put<NoteController>(NoteController(
          getIt(),
          getIt(),
          getIt(),
          getNoteByStatus: getIt(),
          updateNoteUseCase: getIt(),
        ));
      })
    ),
    GetPage(
      name: noteDetail,
      page: () => NoteDetailPage(),
    ),
  ];
}