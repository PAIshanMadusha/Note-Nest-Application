import 'package:flutter/material.dart';
import 'package:note_nest_application/models/todo_model.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/widgets/todo_card.dart';

class TodoTab extends StatefulWidget {
  final List<TodoModel> incompletedTodos;
  const TodoTab({
    super.key,
    required this.incompletedTodos,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
