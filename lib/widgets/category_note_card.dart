import 'package:flutter/material.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';

class CategoryNoteCard extends StatefulWidget {
  final String noteTitle;
  final String noteContent;
  final Future Function() removeNote;
  final Future Function() editNote;

  const CategoryNoteCard({
    super.key,
    required this.noteTitle,
    required this.noteContent,
    required this.removeNote,
    required this.editNote,
  });

  @override
  State<CategoryNoteCard> createState() => _CategoryNoteCardState();
}

class _CategoryNoteCardState extends State<CategoryNoteCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // ignore: deprecated_member_use
      color: AppColors.kWhiteColor.withOpacity(0.15),
      child: Padding(
        padding: EdgeInsets.all(
          AppConstants.kDefaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.noteTitle,
              style: AppTextStyles.appButton,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: AppConstants.kSizedBoxValue,
            ),
            Text(
              widget.noteContent,
              style: AppTextStyles.appSmallDescription.copyWith(
                // ignore: deprecated_member_use
                color: AppColors.kWhiteColor.withOpacity(0.7),
              ),
              maxLines: 7,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: widget.editNote,
                  icon: Icon(
                    Icons.edit_note_outlined,
                    color: AppColors.kCircleColorG2,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: widget.removeNote,
                  icon: Icon(
                    Icons.delete_outline,
                    color: AppColors.kCircleColorG2,
                    size: 30,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
