import 'package:flutter/material.dart';
import 'package:note_nest_application/utils/app_router.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "NoteNest",
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}