import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_nest_application/pages/home_page.dart';

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
        builder: (context, state){
          return const HomePage();
        },
      ),
    ],
  );
}
