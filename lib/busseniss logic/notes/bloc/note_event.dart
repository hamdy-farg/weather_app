part of 'note_bloc.dart';

@immutable
sealed class NoteEvent {}

class PerformNote extends NoteEvent {
  final String descriptoin;
  final String city_name;
  PerformNote({required this.city_name, required this.descriptoin});
}

class PerformDeleteNote extends NoteEvent {
  final Note note;
  PerformDeleteNote({required this.note});
}

class PerformUpdateNote extends NoteEvent {
  final int index;
  final Note note;
  PerformUpdateNote({required this.note, required this.index});
}
