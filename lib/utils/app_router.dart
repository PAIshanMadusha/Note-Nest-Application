import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_nest_application/pages/home_page.dart';
import 'package:note_nest_application/pages/note_by_category.dart';
import 'package:note_nest_application/pages/notes_page.dart';
import 'package:note_nest_application/pages/todo_list_page.dart';

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
    ],
  );
}
