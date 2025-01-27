import 'package:flutter/material.dart';
import 'package:note_nest_application/utils/app_colors.dart';

class AppThemeData {
  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().primaryColor,
    scaffoldBackgroundColor: AppColors.kBackGroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.kWhiteColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kBackGroundColor,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: AppColors.kWhiteColor,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.kFActionButtonColor,
    ),
  );
}
