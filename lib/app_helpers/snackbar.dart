import 'package:flutter/material.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';

class AppHelper {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kBackGroundColor,
        content: Text(
          message,
          style: AppTextStyles.appSmallDescription,
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
