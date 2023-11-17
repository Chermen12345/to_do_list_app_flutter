import 'package:to_do_list/data/models/todo.dart';

abstract class GetNotesEvent {}

class GetNotes extends GetNotesEvent {}

class AddNote extends GetNotesEvent {
  String title;
  String content;
  AddNote(this.title, this.content);
}

class DeleteNote extends GetNotesEvent {
  int index;
  DeleteNote(this.index);
}

class UpdateNote extends GetNotesEvent {
  ToDo toDo;
  int index;
  UpdateNote(this.index, this.toDo);
}
