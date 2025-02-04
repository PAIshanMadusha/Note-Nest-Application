import 'package:flutter/material.dart';
import 'package:note_nest_application/models/todo_model.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';

class TodoCard extends StatefulWidget {
  final TodoModel todo;
  final bool isCompleted;
  final Function() onCheckBoxMarked;
  const TodoCard({
    super.key,
    required this.todo,
    required this.isCompleted, 
    required this.onCheckBoxMarked,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15,
        ),
        gradient: AppColors().kMainCardColor,
      ),
      child: ListTile(
        title: Text(
          widget.todo.title,
          style: AppTextStyles.appButton,
        ),
        subtitle: Row(
          children: [
            Text(
              "${widget.todo.date.day}/${widget.todo.date.month}/${widget.todo.date.year}",
              style: AppTextStyles.appSmallDescription,
            ),
            SizedBox(
              width: AppConstants.kSizedBoxValue - 5,
            ),
            Text(
              "${widget.todo.time.hour}:${widget.todo.time.minute}",
              style: AppTextStyles.appSmallDescription,
            ),
          ],
        ),
        trailing: Checkbox(
          value: widget.isCompleted,
          onChanged: (bool? value) => widget.onCheckBoxMarked(),
        ),
      ),
    );
  }
}
