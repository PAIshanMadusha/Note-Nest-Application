import 'package:flutter/material.dart';
import 'package:note_nest_application/app_helpers/snackbar.dart';
import 'package:note_nest_application/models/note_model.dart';
import 'package:note_nest_application/services/note_service.dart';
import 'package:note_nest_application/utils/app_constants.dart';
import 'package:note_nest_application/utils/app_router.dart';
import 'package:note_nest_application/utils/app_text_styles.dart';
import 'package:note_nest_application/widgets/category_note_card.dart';

class NoteByCategory extends StatefulWidget {
  final String category;
  const NoteByCategory({
    super.key,
    required this.category,
  });

  @override
  State<NoteByCategory> createState() => _NoteByCategoryState();
}

class _NoteByCategoryState extends State<NoteByCategory> {
  final NoteService noteService = NoteService();
  List<NoteModel> noteList = [];

  @override
  void initState() {
    super.initState();
    _loadNotesByCategory();
  }

  //Load all notes by category
  Future<void> _loadNotesByCategory() async {
    noteList = await noteService.getNotesByCategoryName(widget.category);
    setState(() {});
  }

  //Edit Note
  void _editNote(NoteModel note) {
    AppRouter.router.push("/edit-note", extra: note);
  }

  //Delete Note
  Future<void> _removeNote(String id) async {
    try {
      await noteService.deleteNote(id);
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        AppHelper.showSnackBar(context, "Note Deleted Successfully!");
      }
    } catch (error) {
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        AppHelper.showSnackBar(context, "Error: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            //To Note Page
            AppRouter.router.push("/notes");
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "${widget.category} Category",
          style: AppTextStyles.appSubTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            AppConstants.kDefaultPadding,
          ),
          child: Column(
            children: [
              Text(
                "${widget.category} Notes",
                style: AppTextStyles.appButton,
              ),
              SizedBox(
                height: AppConstants.kSizedBoxValue,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppConstants.kDefaultPadding,
                  mainAxisSpacing: AppConstants.kDefaultPadding,
                  childAspectRatio: 7 / 11,
                ),
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  return CategoryNoteCard(
                    noteTitle: noteList[index].title,
                    noteContent: noteList[index].content,
                    removeNote: () async {
                      await _removeNote(noteList[index].id);
                      setState(() {
                        noteList.removeAt(index);
                      });
                    },
                    editNote: () async {
                      _editNote(noteList[index]);
                    },
                    viewSingleNote: () async {
                      AppRouter.router.push(
                        "/single-note",
                        extra: noteList[index],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
