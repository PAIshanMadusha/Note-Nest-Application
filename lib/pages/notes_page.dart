import 'package:flutter/material.dart';
import 'package:note_nest_application/models/note_model.dart';
import 'package:note_nest_application/services/note_service.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_router.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';
import 'package:note_nest_application/widgets/category_input_bottom_sheet.dart';
import 'package:note_nest_application/widgets/notes_card.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NoteService noteService = NoteService();
  List<NoteModel> allNotes = [];
  Map<String, List<NoteModel>> notesWithCategory = {};

  @override
  void initState() {
    super.initState();
    _checkNewUserAndCreateIniNotes();
  }

  //Check user
  void _checkNewUserAndCreateIniNotes() async {
    final bool isNewUser = await noteService.isNewUser();
    //Create Initail Notes
    if (isNewUser) {
      await noteService.createdInitialNotes();
    }
    //Load
    _loadNotes();
  }

  //Load Notes
  Future<void> _loadNotes() async {
    final List<NoteModel> loadedNotes = await noteService.loadNotes();
    final Map<String, List<NoteModel>> notesByCategory =
        noteService.getNotesByCategoryMap(loadedNotes);
    setState(() {
      allNotes = loadedNotes;
      notesWithCategory = notesByCategory;
    });
  }

  //Bottom Sheet
  void openBottomSheet() {
    showModalBottomSheet(
      // ignore: deprecated_member_use
      barrierColor: AppColors.kBackGroundColor.withOpacity(0.7),
      context: context,
      builder: (context) {
        return CategoryInputBottomSheet(
          onNewNote: () {
            Navigator.pop(context);
            AppRouter.router.push("/create-note", extra: false);
          },
          onNewCategory: () {
            Navigator.pop(context);
            AppRouter.router.push("/create-note", extra: true);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            AppRouter.router.go("/");
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Notes",
          style: AppTextStyles.appSubTitle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openBottomSheet,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.kWhiteColor,
            width: 2,
          ),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.kWhiteColor,
          size: 35,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          AppConstants.kDefaultPadding,
        ),
        child: Column(
          children: [
            Text(
              "Notes Categories",
              style: AppTextStyles.appSubTitle,
            ),
            SizedBox(
              height: AppConstants.kSizedBoxValue,
            ),
            allNotes.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Text(
                      "No Notes Are Available, Please Add+ Some Notes",
                      style: AppTextStyles.appBody,
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppConstants.kDefaultPadding,
                      mainAxisSpacing: AppConstants.kDefaultPadding,
                      childAspectRatio: 6 / 4,
                    ),
                    itemCount: notesWithCategory.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          //Notes by Category
                          AppRouter.router.push(
                            "/category",
                            extra: notesWithCategory.keys.elementAt(index),
                          );
                        },
                        child: NotesCard(
                          noteCategory: notesWithCategory.keys.elementAt(index),
                          noOfNotes:
                              notesWithCategory.keys.elementAt(index).length,
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
