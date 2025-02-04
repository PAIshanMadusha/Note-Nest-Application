import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_nest_application/models/note_model.dart';
import 'package:note_nest_application/models/todo_model.dart';
import 'package:note_nest_application/pages/todo_inharited_widget.dart';
import 'package:note_nest_application/utils/app_router.dart';
import 'package:note_nest_application/utils/app_theme_data.dart';

void main() async{

  //Hive
  await Hive.initFlutter();

  //Register
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(TodoModelAdapter());

  //Open Hive Boxes
  await Hive.openBox('notes');
  await Hive.openBox('todos');
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoInharitedWidget(
      todos: [],
      onTodosChanged: (){},
      child: MaterialApp.router(
        title: "NoteNest",
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.darkTheme.copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
