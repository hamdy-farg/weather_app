import 'package:wheather_app/data/model/note.dart';

class GetNotes {
  // to save the data static in the class until we  create the DB
  static List<Note> note_collection = [];

  //  add note in the list
  addNote(String description, city_name) {
    note_collection.add(Note(city_name: city_name, description: description));
  }

  // delete the note from the list
  deleteNote(Note note) {
    note_collection
        .removeWhere((element) => element.description == note.description);
  }

  // update the note on the list
  updateNote(Note note, int index) {
    note_collection[index] = note;
  }
}
