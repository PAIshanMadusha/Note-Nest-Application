import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_nest_application/models/note_model.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';

class SingleNotePage extends StatefulWidget {
  final NoteModel note;
  const SingleNotePage({
    super.key,
    required this.note,
  });

  @override
  State<SingleNotePage> createState() => _SingleNotePageState();
}

class _SingleNotePageState extends State<SingleNotePage> {
  @override
  Widget build(BuildContext context) {
    //Date
    final forDate = DateFormat.yMMMd().format(widget.note.date);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Note",
          style: AppTextStyles.appSubTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            AppConstants.kDefaultPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.note.title,
                style: AppTextStyles.appTitle,
              ),
              Text(
                "Category: ${widget.note.category}",
                style: AppTextStyles.appSmallDescription.copyWith(
                  color: AppColors.kCircleColorG2,
                ),
              ),
              SizedBox(
                height: AppConstants.kSizedBoxValue * 2,
              ),
              Text(
                widget.note.content,
                style: AppTextStyles.appSmallDescription.copyWith(
                  // ignore: deprecated_member_use
                  color: AppColors.kWhiteColor.withOpacity(0.7),
                ),
              ),
              SizedBox(
                height: AppConstants.kSizedBoxValue * 2,
              ),
              Text(
                forDate,
                style: AppTextStyles.appSmallDescription.copyWith(
                  color: AppColors.kFActionButtonColor
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
