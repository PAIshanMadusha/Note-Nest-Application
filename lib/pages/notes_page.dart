import 'package:flutter/material.dart';
import 'package:note_nest_application/models/note_model.dart';
import 'package:note_nest_application/services/note_service.dart';
import 'package:note_nest_application/utils/app_colors.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_router.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';

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
        onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
