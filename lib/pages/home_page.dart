import 'package:flutter/material.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';
import 'package:note_nest_application/widgets/notes_todo_card.dart';
import 'package:note_nest_application/widgets/progress_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              completedTask: 3,
              totalTasks: 10,
            ),
            SizedBox(
              height: AppConstants.kSizedBoxValue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NotesTodoCard(
                  icon: Icons.bookmark_add_outlined,
                  title: "Notes",
                  description: "3 notes",
                ),
                NotesTodoCard(
                  icon: Icons.today_outlined,
                  title: "To-Do List",
                  description: "3 Tasks",
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
          ],
        ),
      ),
    );
  }
}
