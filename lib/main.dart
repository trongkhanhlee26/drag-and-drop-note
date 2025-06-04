import 'package:flutter/material.dart';
import 'package:flutter_application_drag_and_drop/injection_container.dart';
import 'package:flutter_application_drag_and_drop/note/presentation/routes/app_routes.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.notePage,
      getPages: AppRoutes.routes,
    );
  }
}


