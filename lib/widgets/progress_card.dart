import 'package:flutter/material.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';

class ProgressCard extends StatefulWidget {
  final int completedTask;
  final int totalTasks;

  const ProgressCard({
    super.key,
    required this.completedTask,
    required this.totalTasks,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    //Calculation for the Percentage
    double completionPercentage = widget.totalTasks != 0
        ? (widget.completedTask / widget.totalTasks) * 100
        : 0;
    return Container(
      padding: EdgeInsets.all(
        AppConstants.kDefaultPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: AppColors().kMainCardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kWhiteColor,
            blurRadius: 1,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Progress",
                style: AppTextStyles.appSubTitle,
              ),
              SizedBox(
                height: AppConstants.kSizedBoxValue,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text(
                  "You Have Completed ${widget.completedTask} Out Of ${widget.totalTasks} Task, Keep Up the Progress!",
                  // ignore: deprecated_member_use
                  style: AppTextStyles.appSmallDescription.copyWith(
                    // ignore: deprecated_member_use
                    color: AppColors.kWhiteColor.withOpacity(0.75),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(
            width: AppConstants.kSizedBoxValue,
          ),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: AppColors().kMainCircleColor,
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    "${completionPercentage.toStringAsFixed(1)}%",
                    style: AppTextStyles.appSubTitle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
