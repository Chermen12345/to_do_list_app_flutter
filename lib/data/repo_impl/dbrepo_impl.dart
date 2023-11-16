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
  deleteNote(String content) {
    // TODO: implement deleteNote
    GetIt.I<DbMethods>().deleteToDo(content);
  }
}
