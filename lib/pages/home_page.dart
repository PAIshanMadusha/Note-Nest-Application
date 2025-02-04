import 'package:flutter/material.dart';
import 'package:note_nest_application/models/note_model.dart';
import 'package:note_nest_application/models/todo_model.dart';
import 'package:note_nest_application/services/note_service.dart';
import 'package:note_nest_application/services/todo_service.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_router.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';
import 'package:note_nest_application/widgets/home_todo_card.dart';
import 'package:note_nest_application/widgets/notes_todo_card.dart';
import 'package:note_nest_application/widgets/progress_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoteModel> allNotes = [];
  List<TodoModel> allTodos = [];

  @override
  void initState() {
    _checkIfUserIsNew();
    super.initState();
    setState(() {});
  }

  void _checkIfUserIsNew() async {
    final bool isNewUser =
        await NoteService().isNewUser() || await TodoService().isNewUser();

    if (isNewUser) {
      await NoteService().createdInitialNotes();
      await TodoService().createInitialTodos();
    }
    _loadNotes();
    _loadTodos();
  }

  Future<void> _loadNotes() async {
    final List<NoteModel> loadedNotes = await NoteService().loadNotes();

    setState(() {
      allNotes = loadedNotes;
    });
  }

  Future<void> _loadTodos() async {
    final List<TodoModel> loadedTodos = await TodoService().loadTodos();

    setState(() {
      allTodos = loadedTodos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NoteNest",
          style: AppTextStyles.appTitle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppConstants.kDefaultPadding,
          horizontal: AppConstants.kDefaultPadding,
        ),
        child: Column(
          children: [
            ProgressCard(
              completedTask: allTodos.where((todo) => todo.isDone).length,
              totalTasks: allTodos.length,
            ),
            SizedBox(
              height: AppConstants.kSizedBoxValue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/notes");
                  },
                  child: NotesTodoCard(
                    icon: Icons.bookmark_add_outlined,
                    title: "Notes",
                    description: "${allNotes.length.toString()} Notes",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/todos");
                  },
                  child: NotesTodoCard(
                    icon: Icons.today_outlined,
                    title: "To-Do List",
                    description: "${allTodos.length.toString()} Tasks",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppConstants.kSizedBoxValue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Progress",
                  style: AppTextStyles.appSubTitle,
                ),
                Text(
                  "See More...",
                  style: AppTextStyles.appSmallDescription.copyWith(
                    // ignore: deprecated_member_use
                    color: AppColors.kWhiteColor.withOpacity(
                      0.8,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppConstants.kSizedBoxValue,
            ),
            allTodos.isEmpty
                ? Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Add Some Task to Get Started!",
                            style: AppTextStyles.appSubTitle.copyWith(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: AppConstants.kSizedBoxValue,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                  horizontal: AppConstants.kDefaultPadding,
                                  vertical: AppConstants.kDefaultPadding - 10,
                                ),
                              ),
                              backgroundColor: WidgetStatePropertyAll(
                                AppColors.kFActionButtonColor,
                              ),
                            ),
                            onPressed: () {
                              AppRouter.router.push("/todos");
                            },
                            child: Text(
                              "Add a Task",
                              style: AppTextStyles.appButton,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: allNotes.length,
                      itemBuilder: (context, index) {
                        final TodoModel todo = allTodos[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: AppConstants.kDefaultPadding - 5,
                          ),
                          child: HomeTodoCard(
                            title: todo.title,
                            date: todo.date.toString(),
                            time: todo.time.toString(),
                            isDone: todo.isDone,
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
