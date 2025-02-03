import 'package:flutter/material.dart';
import 'package:note_nest_application/app_helpers/snackbar.dart';
import 'package:note_nest_application/models/todo_model.dart';
import 'package:note_nest_application/services/todo_service.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_router.dart';
import 'package:note_nest_application/widgets/todo_card.dart';

class CompletedTab extends StatefulWidget {
  final List<TodoModel> completedTodos;
  final List<TodoModel> incompletedTodos;
  const CompletedTab({
    super.key,
    required this.completedTodos, 
    required this.incompletedTodos,
  });

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  //Mark As Todo Undone
  void _markTodoAsDone(TodoModel todo) async {
    try {
      final TodoModel updatedTodo = TodoModel(
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: false,
      );
      await TodoService().markAsDone(updatedTodo);
      setState(() {
        widget.completedTodos.remove(todo);
        widget.incompletedTodos.add(updatedTodo);
      });
      AppHelper.showSnackBar(context, "Marked As Undone!");
      AppRouter.router.go("/todos");
    } catch (error) {
      error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.completedTodos.sort((a, b) => a.time.compareTo(b.time));
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
              itemCount: widget.completedTodos.length,
              itemBuilder: (context, index) {
                final TodoModel todo = widget.completedTodos[index];
                return TodoCard(
                  todo: todo,
                  isCompleted: true,
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
