import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_nest_application/models/note_model.dart';
import 'package:note_nest_application/services/note_service.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';

class UpdateNotePage extends StatefulWidget {
  final NoteModel note;
  const UpdateNotePage({
    super.key,
    required this.note,
  });

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  List<String> categories = [];

  final NoteService noteService = NoteService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  String category = "";

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  Future _loadCategories() async {
    categories = await noteService.getAllCategories();
    setState(() {});
  }

  @override
  void initState() {
    _noteTitleController.text = widget.note.title;
    _noteContentController.text = widget.note.content;
    category = widget.note.category;
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update a Note",
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
                    Container(
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
                      controller: _noteContentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter a Note Content";
                        }
                        return null;
                      },
                      maxLines: 12,
                      textAlign: TextAlign.center,
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
                            
                          },
                          child: Text(
                            "Update Note",
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
