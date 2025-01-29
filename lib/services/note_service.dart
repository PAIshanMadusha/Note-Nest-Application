import 'package:hive/hive.dart';
import 'package:note_nest_application/models/note_model.dart';
import 'package:uuid/uuid.dart';

class NoteService {
  List<NoteModel> allNotes = [
    NoteModel(
      id: const Uuid().v4(),
      title: "MeetingNotes",
      category: "Work",
      content: "Discussed Project deadline and deliverables",
      date: DateTime.now(),
    ),
    NoteModel(
      id: const Uuid().v4(),
      title: "Action Games",
      category: "Games",
      content:
          "Played an Action Game at Mid-Night, Played an Action Game at Mid-Night",
      date: DateTime.now(),
    ),
    NoteModel(
      id: const Uuid().v4(),
      title: "A Flutter Project",
      category: "Project",
      content:
          "Developing a flutter project in nowdays, Developing a flutter project in nowdays",
      date: DateTime.now(),
    ),
  ];

  //Create the database refrence for notes
  final _myBox = Hive.box('notes');

  //Check new user or not
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  //Create initails notes if the box is empty
  Future<void> createdInitialNotes() async {
    if (_myBox.isEmpty) {
      await _myBox.put("notes", allNotes);
    }
  }

  //Load notes
  Future<List<NoteModel>> loadNotes() async {
    final dynamic notes = _myBox.get("notes");

    if (notes != null && notes is List<dynamic>) {
      return notes.cast<NoteModel>().toList();
    }
    return [];
  }

  //Category
  Map<String, List<NoteModel>> getNotesByCategoryMap(List<NoteModel> allNotes) {
    final Map<String, List<NoteModel>> notesByCategory = {};

    for (final note in allNotes) {
      if (notesByCategory.containsKey(note.category)) {
        notesByCategory[note.category]!.add(note);
      } else {
        notesByCategory[note.category] = [note];
      }
    }
    return notesByCategory;
  }

  //Get the Notes according to the Category
  Future<List<NoteModel>> getNotesByCategoryName(String category) async {
    final dynamic allNotes = await _myBox.get('notes');
    final List<NoteModel> notes = [];

    for (final note in allNotes) {
      if (note.category == category) {
        notes.add(note);
      }
    }
    return notes;
  }

  //Update and Delete Note
  Future <void> updateNote(NoteModel note) async {
    try {
      final dynamic allNotes = await _myBox.get('notes');
      final int index = allNotes.indexWhere(
        (element) => element.id == note.id,
      );
      allNotes[index] = note;

      await _myBox.put('notes', allNotes);
      // ignore: empty_catches
    } catch (erro) {}
  }

  Future <void> deleteNote(String noteId) async {
    try{
      final dynamic allNotes = await _myBox.get('notes');
      allNotes.removeWhere((element)=> element.id == noteId);
      await _myBox.put('notes', allNotes);
    // ignore: empty_catches
    }catch(error){}
  }
}
