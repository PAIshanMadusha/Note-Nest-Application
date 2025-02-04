import 'package:flutter/material.dart';
import 'package:note_nest_application/models/todo_model.dart';

class TodoInharitedWidget extends InheritedWidget {
  final List<TodoModel> todos;
  final Function() onTodosChanged;

  const TodoInharitedWidget({
    super.key,
    required super.child,
    required this.todos,
    required this.onTodosChanged,
  });

  static TodoInharitedWidget? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<TodoInharitedWidget>();
  }
  
  @override
  bool updateShouldNotify(covariant TodoInharitedWidget oldWidget) {
    return todos != oldWidget.todos;
  }
}
