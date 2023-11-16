import 'package:to_do_list/data/models/todo.dart';

abstract class DbRepo {
  addNote(ToDo toDo);
  deleteNote(String content);
  Future<List<ToDo>> getNotes();
}
