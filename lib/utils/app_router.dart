import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_nest_application/models/note_model.dart';
import 'package:note_nest_application/pages/create_a_new_note_page.dart';
import 'package:note_nest_application/pages/home_page.dart';
import 'package:note_nest_application/pages/note_by_category_page.dart';
import 'package:note_nest_application/pages/notes_page.dart';
import 'package:note_nest_application/pages/single_note_page.dart';
import 'package:note_nest_application/pages/todo_list_page.dart';
import 'package:note_nest_application/pages/update_note_page.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: [
      //HomePage
      GoRoute(
        name: "HomePage",
        path: "/",
        builder: (context, state) {
          return const HomePage();
        },
      ),
      //NotesPage
      GoRoute(
        name: "NotesPage",
        path: "/notes",
        builder: (context, state) {
          return const NotesPage();
        },
      ),
      //To-DoPage
      GoRoute(
        name: "To-DoPage",
        path: "/todos",
        builder: (context, state) {
          return const TodoListPage();
        },
      ),
      //Note by CategoryPage
      GoRoute(
        name: "Notes By Category",
        path: "/category",
        builder: (context, state) {
          final String category = state.extra as String;
          return NoteByCategory(category: category);
        },
      ),
      //Create a New Note
      GoRoute(
        name: "Crate a Note",
        path: "/create-note",
        builder: (context, state) {
          final isNewCategoryPage = state.extra as bool;
          return CreateANewNotePage(
            isNewCategory: isNewCategoryPage,
          );
        },
      ),
      //Edit Note
      GoRoute(
        name: "EditNote",
        path: "/edit-note",
        builder: (context, state) {
          final NoteModel note = state.extra as NoteModel;
          return UpdateNotePage(
            note: note,
          );
        },
      ),
      //NoteView
      GoRoute(
        name: "NoteView",
        path: "/single-note",
        builder: (context, state) {
          final NoteModel note = state.extra as NoteModel;
          return SingleNotePage(note: note);
        },
      )
    ],
  );
}
