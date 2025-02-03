import 'package:flutter/material.dart';
import 'package:note_nest_application/app_helpers/snackbar.dart';
import 'package:note_nest_application/models/todo_model.dart';
import 'package:note_nest_application/services/todo_service.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_router.dart';
import 'package:note_nest_application/widgets/todo_card.dart';

class TodoTab extends StatefulWidget {
  final List<TodoModel> incompletedTodos;
  final List<TodoModel> completedTodos;
  const TodoTab({
    super.key,
    required this.incompletedTodos, 
    required this.completedTodos,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  //Mark a Todo as Done
  void _markTodoAsDone(TodoModel todo) async{
    try {
      final TodoModel updatedTodo = TodoModel(
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: true,
      );
      await TodoService().markAsDone(updatedTodo);
      AppHelper.showSnackBar(context, "Marked As Done!");
      setState(() {
        widget.incompletedTodos.remove(todo);
        widget.completedTodos.add(updatedTodo);
      });
      AppRouter.router.go("/todos");
    } catch (error) {
      error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.incompletedTodos.sort((a,b) => a.time.compareTo(b.time));
    });
    return Padding(
      padding: EdgeInsets.all(
        AppConstants.kDefaultPadding - 5,
      ),
      child: Column(
        children: [
          SizedBox(
            height: AppConstants.kSizedBoxValue,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.incompletedTodos.length,
              itemBuilder: (context, index) {
                final TodoModel todo = widget.incompletedTodos[index];
                return TodoCard(
                  todo: todo,
                  isCompleted: false,
                  onCheckBoxMarked: () => _markTodoAsDone(todo),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
