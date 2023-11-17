import 'package:to_do_list/data/models/todo.dart';

abstract class DbRepo {
  addNote(ToDo toDo);
  deleteNote(int index);
  Future<List<ToDo>> getNotes();
  updateNote(int index, ToDo toDo);
}
