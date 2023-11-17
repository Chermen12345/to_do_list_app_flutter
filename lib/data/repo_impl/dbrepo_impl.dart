import 'package:get_it/get_it.dart';
import 'package:to_do_list/data/local_data_source/db_methods.dart';
import 'package:to_do_list/data/models/todo.dart';
import 'package:to_do_list/features/todolist/domain/repos/dbrepo.dart';

class DbRepoImpl implements DbRepo {
  @override
  addNote(ToDo toDo) {
    GetIt.I<DbMethods>().addToDo(toDo);
  }

  @override
  Future<List<ToDo>> getNotes() async {
    return GetIt.I<DbMethods>().getToDos();
  }

  @override
  deleteNote(int index) {
    // TODO: implement deleteNote
    GetIt.I<DbMethods>().deleteToDo(index);
  }

  @override
  updateNote(int index, ToDo toDo) {
    // TODO: implement updateNote
    GetIt.I<DbMethods>().updateToDo(index, toDo);
  }
}
