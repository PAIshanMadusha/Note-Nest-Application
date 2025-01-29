import 'package:flutter/material.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';

class NotesCard extends StatelessWidget {
  final String noteCategory;
  final int noOfNotes;

  const NotesCard({
    super.key,
    required this.noteCategory,
    required this.noOfNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        AppConstants.kDefaultPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: AppColors().kMainCircleColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kWhiteColor,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            noteCategory,
            style: AppTextStyles.appSubTitle,
          ),
          Text(
            "$noteCategory Notes",
            style: AppTextStyles.appSmallDescription.copyWith(
              // ignore: deprecated_member_use
              color: AppColors.kWhiteColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
