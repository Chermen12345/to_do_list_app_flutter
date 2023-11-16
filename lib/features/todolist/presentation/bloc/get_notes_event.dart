abstract class GetNotesEvent {}

class GetNotes extends GetNotesEvent {}

class AddNote extends GetNotesEvent {
  String title;
  String content;
  AddNote(this.title, this.content);
}

class DeleteNote extends GetNotesEvent {
  String content;
  DeleteNote(this.content);
}
