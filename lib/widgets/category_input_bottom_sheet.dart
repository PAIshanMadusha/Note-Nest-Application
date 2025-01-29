import 'package:flutter/material.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';

class CategoryInputBottomSheet extends StatefulWidget {
  final Function() onNewNote;
  final Function() onNewCategory;

  const CategoryInputBottomSheet({
    super.key,
    required this.onNewNote,
    required this.onNewCategory,
  });

  @override
  State<CategoryInputBottomSheet> createState() =>
      _CategoryInputBottomSheetState();
}

class _CategoryInputBottomSheetState extends State<CategoryInputBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        // ignore: deprecated_member_use
        color: AppColors.kBackGroundColor.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.kDefaultPadding,
          vertical: AppConstants.kDefaultPadding * 2,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: widget.onNewNote,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create a New Note",
                    style: AppTextStyles.appDescription,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                  )
                ],
              ),
            ),
            SizedBox(
              height: AppConstants.kSizedBoxValue,
            ),
            Divider(
              thickness: 1,
              color: AppColors.kWhiteColor,
            ),
            SizedBox(
              height: AppConstants.kSizedBoxValue,
            ),
            GestureDetector(
              onTap: widget.onNewCategory,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create a New Note Category",
                    style: AppTextStyles.appDescription,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
