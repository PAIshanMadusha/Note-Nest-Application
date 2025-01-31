import 'package:flutter/material.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';
import 'package:note_nest_application/widgets/completed_tab.dart';
import 'package:note_nest_application/widgets/todo_tab.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          dividerColor: AppColors.kBackGroundColor,
          indicatorColor: AppColors.kCircleColorG2,
          tabs: [
            Tab(
              child: Text(
                "To-Do",
                style: AppTextStyles.appButton,
              ),
            ),
            Tab(
              child: Text(
                "Completed",
                style: AppTextStyles.appButton,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.kWhiteColor,
            width: 2,
          ),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.kWhiteColor,
          size: 35,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TodoTab(),
          CompletedTab(),
        ],
      ),
    );
  }
}
