part of 'note_bloc.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class Noteloading extends NoteState {}

final class NoteLoaded extends NoteState {
  List<Note> notes;
  NoteLoaded({required this.notes});
}

final class NoteError extends NoteState {
  final String msg;
  NoteError({required this.msg});
}
