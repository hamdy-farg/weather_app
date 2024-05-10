import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:wheather_app/data/model/note.dart';
import 'package:wheather_app/data/repo/get_notes.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteInitial()) {
    on<PerformNote>((event, emit) {
      try {
        GetNotes().addNote(event.descriptoin, event.city_name);
        emit(NoteInitial());
      } catch (e) {
        emit(NoteError(msg: e.toString()));
      }

      emit(Noteloading());
      try {
        // get the all note to display
        List<Note> notes = GetNotes.note_collection;

        emit(NoteLoaded(notes: notes));
      } catch (e) {
        emit(NoteError(msg: e.toString()));
      }
    });

    on<PerformDeleteNote>((event, emit) {
      emit(Noteloading());
      try {
        // do delete
        GetNotes().deleteNote(event.note);
        // retrieve the all note to display
        List<Note> notes = GetNotes.note_collection;
        emit(NoteLoaded(notes: notes));
      } catch (e) {
        emit(NoteError(msg: e.toString()));
      }
    });
    on<PerformUpdateNote>((event, emit) {
      // do the update
      try {
        GetNotes().updateNote(event.note, event.index);
        emit(NoteInitial());
      } catch (e) {
        emit(NoteError(msg: e.toString()));
      }
      // retrieve the all note to display
      emit(Noteloading());
      try {
        List<Note> notes = GetNotes.note_collection;
        emit(NoteLoaded(notes: notes));
      } catch (e) {
        emit(NoteError(msg: e.toString()));
      }
    });
  }
}
