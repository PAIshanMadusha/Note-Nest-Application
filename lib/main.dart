import 'package:flutter/material.dart';
import 'package:note_nest_application/pages/home_page.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NoteNest",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}