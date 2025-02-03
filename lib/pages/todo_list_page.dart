import 'package:flutter/material.dart';
import 'package:note_nest_application/models/todo_model.dart';
import 'package:note_nest_application/services/todo_service.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_router.dart';
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

  late List<TodoModel> allTodos = [];
  late List<TodoModel> incompletedTodos = [];
  late List<TodoModel> completedTodos = [];

  TodoService todoService = TodoService();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _checkIfUserIsNew();
    super.initState();
  }

  void _checkIfUserIsNew() async {
    final bool isNewUser = await todoService.isNewUser();
    if (isNewUser) {
      await todoService.createInitialTodos();
    }
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final List<TodoModel> loadedTodos = await todoService.loadTodos();
    setState(
      () {
        allTodos = loadedTodos;
        //Incompleted
        incompletedTodos = allTodos.where((todo) => !todo.isDone).toList();
        //Completed
        completedTodos = allTodos.where((todo) => todo.isDone).toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            AppRouter.router.push("/");
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "To-Do List",
          style: AppTextStyles.appSubTitle,
        ),
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
          TodoTab(
            incompletedTodos: incompletedTodos,
            completedTodos: completedTodos,
          ),
          CompletedTab(
            completedTodos: completedTodos,
            incompletedTodos: incompletedTodos,
          ),
        ],
      ),
    );
  }
}
