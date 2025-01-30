import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_nest_application/services/note_service.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';

class CreateANewNotePage extends StatefulWidget {
  final bool isNewCategory;
  const CreateANewNotePage({
    super.key,
    required this.isNewCategory,
  });

  @override
  State<CreateANewNotePage> createState() => _CreateANewNotePageState();
}

class _CreateANewNotePageState extends State<CreateANewNotePage> {
  List<String> categories = [];

  final NoteService noteService = NoteService();

  Future _loadCategories() async {
    categories = await noteService.getAllCategories();
    setState(() {});
  }

  @override
  void initState() {
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isNewCategory
            ? Text(
              "Create a Note Category",
                style: AppTextStyles.appSubTitle,
              )
            : Text(
                "Create a Note",
                style: AppTextStyles.appSubTitle,
              ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: AppConstants.kSizedBoxValue,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppConstants.kDefaultPadding,
              ),
              child: Form(
                child: Column(
                  children: [
                    //Dropdown
                    widget.isNewCategory
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              style: AppTextStyles.appSmallDescription,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColors.kWhiteColor,
                                      width: 2,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: AppColors.kWhiteColor,
                                    width: 2,
                                  ),
                                ),
                                hintText: "Add a Category",
                                hintStyle:
                                    AppTextStyles.appSmallDescription.copyWith(
                                  // ignore: deprecated_member_use
                                  color: AppColors.kWhiteColor.withOpacity(0.7),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: DropdownButtonFormField(
                                style: TextStyle(
                                  fontFamily: GoogleFonts.roboto().fontFamily,
                                ),
                                isExpanded: false,
                                hint: Text(
                                  "Select a Category",
                                  style: AppTextStyles.appDescription.copyWith(
                                    // ignore: deprecated_member_use
                                    color:
                                        // ignore: deprecated_member_use
                                        AppColors.kWhiteColor.withOpacity(0.7),
                                    fontFamily: GoogleFonts.roboto().fontFamily,
                                  ),
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColors.kWhiteColor,
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: AppColors.kWhiteColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                items: categories.map(
                                  (String category) {
                                    return DropdownMenuItem<String>(
                                      alignment: Alignment.centerLeft,
                                      value: category,
                                      child: Text(
                                        category,
                                        style: AppTextStyles.appDescription,
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {}),
                          ),
                    SizedBox(
                      height: AppConstants.kSizedBoxValue,
                    ),
                    //TextFormField
                    TextFormField(
                      textAlign: TextAlign.justify,
                      maxLines: 4,
                      style: AppTextStyles.appButton,
                      decoration: InputDecoration(
                        hintText: "Note Title",
                        hintStyle: AppTextStyles.appTitle.copyWith(
                          fontSize: 32,
                          color: AppColors.kBackGroundColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // ignore: deprecated_member_use
                        fillColor: AppColors.kWhiteColor.withOpacity(0.2),
                        filled: true,
                      ),
                    ),
                    SizedBox(
                      height: AppConstants.kSizedBoxValue,
                    ),
                    TextFormField(
                      maxLines: 12,
                      textAlign: TextAlign.justify,
                      style: AppTextStyles.appDescription,
                      decoration: InputDecoration(
                        hintText: "Content",
                        hintStyle: AppTextStyles.appTitle.copyWith(
                          fontSize: 32,
                          color: AppColors.kBackGroundColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // ignore: deprecated_member_use
                        fillColor: AppColors.kWhiteColor.withOpacity(0.2),
                        filled: true,
                      ),
                    ),
                    SizedBox(
                      height: AppConstants.kSizedBoxValue,
                    ),
                    Divider(
                      color: AppColors.kWhiteColor,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: AppConstants.kSizedBoxValue,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.all(12),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                              AppColors.kCardColorG1,
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Save Note",
                            style: AppTextStyles.appButton,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
