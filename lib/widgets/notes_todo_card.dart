import 'package:flutter/material.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';

class NotesTodoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  const NotesTodoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<NotesTodoCard> createState() => _NotesTodoCardState();
}

class _NotesTodoCardState extends State<NotesTodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        gradient: AppColors().kMainCardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          AppConstants.kDefaultPadding,
        ),
        child: Column(
          children: [
            Icon(
              widget.icon,
              color: AppColors.kCircleColorG2,
              size: 60,
            ),
            SizedBox(
              height: AppConstants.kSizedBoxValue,
            ),
            Text(
              widget.title,
              style: AppTextStyles.appSubTitle,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.description,
              style: AppTextStyles.appSmallDescription.copyWith(
                // ignore: deprecated_member_use
                color: AppColors.kWhiteColor.withOpacity(
                  0.75,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
