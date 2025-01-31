import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_nest_application/app_helpers/snackbar.dart';
import 'package:note_nest_application/models/note_model.dart';
import 'package:note_nest_application/services/note_service.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_router.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';
import 'package:uuid/uuid.dart';

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

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  final TextEditingController _noteCategoryController = TextEditingController();
  String category = "";

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteContentController.dispose();
    _noteCategoryController.dispose();
    super.dispose();
  }

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
                key: _formKey,
                child: Column(
                  children: [
                    //Dropdown
                    widget.isNewCategory
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: _noteCategoryController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter a Category";
                                }
                                return null;
                              },
                              style: AppTextStyles.appSmallDescription,
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
                            child: DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Select a Category";
                                }
                                return null;
                              },
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
                              onChanged: (String? value) {
                                setState(() {
                                  category = value!;
                                });
                              },
                            ),
                          ),
                    SizedBox(
                      height: AppConstants.kSizedBoxValue,
                    ),
                    //TextFormField
                    TextFormField(
                      controller: _noteTitleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter a Note Title";
                        }
                        return null;
                      },
                      textAlign: TextAlign.start,
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
                      controller: _noteContentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter a Note Content";
                        }
                        return null;
                      },
                      maxLines: 12,
                      textAlign: TextAlign.start,
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
                          onPressed: () {
                            //Save the Note
                            if (_formKey.currentState!.validate()) {
                              try {
                                noteService.addNote(
                                  NoteModel(
                                    id: Uuid().v4(),
                                    title: _noteTitleController.text,
                                    category: widget.isNewCategory
                                        ? _noteCategoryController.text
                                        : category,
                                    content: _noteContentController.text,
                                    date: DateTime.now(),
                                  ),
                                );
                                AppHelper.showSnackBar(
                                    context, "Note Saved Successfully!");

                                _noteTitleController.clear();
                                _noteContentController.clear();
                                _noteCategoryController.clear();
                                AppRouter.router.push("/notes");
                              } catch (error) {
                                AppHelper.showSnackBar(
                                    context, "Error: $error");
                              }
                            }
                          },
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
