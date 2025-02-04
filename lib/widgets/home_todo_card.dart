import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';

class HomeTodoCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final bool isDone;
  const HomeTodoCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        AppConstants.kDefaultPadding - 5,
      ),
      decoration: BoxDecoration(
        gradient: AppColors().kMainCardColor,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  title,
                  style: AppTextStyles.appSubTitle.copyWith(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: AppConstants.kSizedBoxValue - 15,
                ),
                Text(
                  "${DateFormat.yMMMd().format(DateTime.parse(date))} ${DateFormat.Hm().format(DateTime.parse(time))}",
                  style: AppTextStyles.appSmallDescription.copyWith(
                    color: AppColors.kCircleColorG2,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isDone ? Icons.done_all_outlined : Icons.done_outline,
            color: isDone ? AppColors.kCircleColorG2 : AppColors.kWhiteColor,
          ),
        ],
      ),
    );
  }
}
