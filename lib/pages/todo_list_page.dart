import 'package:flutter/material.dart';
import 'package:note_nest_application/app_helpers/snackbar.dart';
import 'package:note_nest_application/models/todo_model.dart';
import 'package:note_nest_application/pages/todo_inharited_widget.dart';
import 'package:note_nest_application/services/todo_service.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
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

  final TextEditingController _taskController = TextEditingController();
  
  @override
  void dispose() {
    _taskController.dispose();
    _tabController.dispose();
    super.dispose();
  }

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

  //Method to Add Tasks
  void _addaTask() async {
    try {
      if (_taskController.text.isNotEmpty) {
        final TodoModel newTodo = TodoModel(
          title: _taskController.text,
          date: DateTime.now(),
          time: DateTime.now(),
          isDone: false,
        );
        await todoService.addTodo(newTodo);
        _loadTodos();
        // ignore: use_build_context_synchronously
        final todosInherit = TodoInharitedWidget.of(context);
        if(todosInherit != null){
          todosInherit.onTodosChanged();
        }
        if(mounted) {
          AppHelper.showSnackBar(context, "Task Added Successfully!");
        }
        if(mounted) {
          Navigator.of(context).pop();
        }
        _taskController.clear();
      }
    } catch (error) {
      error.toString();
    }
  }

  void openMessageModel(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                15,
              ),
              side: BorderSide(
                color: AppColors.kBackGroundColor,
                width: 1,
              )),
          // ignore: deprecated_member_use
          backgroundColor: AppColors.kWhiteColor.withOpacity(0.9),
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.all(
              AppConstants.kDefaultPadding - 18,
            ),
            child: Text(
              "Add a Task",
              style: AppTextStyles.appTitle.copyWith(
                color: AppColors.kBackGroundColor,
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          content: Padding(
            padding: EdgeInsets.all(
              AppConstants.kDefaultPadding,
            ),
            child: TextField(
              controller: _taskController,
              style: AppTextStyles.appSmallDescription.copyWith(
                color: AppColors.kBackGroundColor,
              ),
              decoration: InputDecoration(
                // ignore: deprecated_member_use
                fillColor: AppColors.kCardColorG1.withOpacity(0.2),
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    borderSide: BorderSide(
                      color: AppColors.kCardColorG1,
                      width: 2,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    borderSide: BorderSide(
                      color: AppColors.kCardColorG1,
                      width: 2,
                    )),
                hintText: "Enter Your Task",
                hintStyle: AppTextStyles.appButton.copyWith(
                  color: AppColors.kCardColorG1,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  AppColors.kFActionButtonColor,
                ),
              ),
              onPressed: () {
                _addaTask();
              },
              child: Text(
                "Add a Task",
                style: AppTextStyles.appSmallDescription,
              ),
            ),
            SizedBox(
              width: AppConstants.kSizedBoxValue - 15,
            ),
            TextButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  AppColors.kBackGroundColor,
                ),
              ),
              onPressed: () {
                _taskController.clear();
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: AppTextStyles.appSmallDescription,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TodoInharitedWidget(
      todos: allTodos,
      onTodosChanged: _loadTodos,
      child: Scaffold(
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
          onPressed: () {
            openMessageModel(context);
          },
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
      ),
    );
  }
}
