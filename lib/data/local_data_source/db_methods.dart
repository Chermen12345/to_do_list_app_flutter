import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list/data/models/todo.dart';

abstract class DbMethods {
  addToDo(ToDo toDo);
  deleteToDo(String content);
  Future<List<ToDo>> getToDos();
}

class DbMethodsImpl implements DbMethods {
  Box<ToDo> todos_box;
  DbMethodsImpl(this.todos_box);
  @override
  addToDo(ToDo toDo) {
    // TODO: implement addToDo
    todos_box.put(toDo.content, toDo);
  }

  @override
  Future<List<ToDo>> getToDos() async {
    // TODO: implement getToDos
    final todo_list = todos_box.values.toList();
    return todo_list;
  }

  @override
  deleteToDo(String content) {
    // TODO: implement deleteToDo
    todos_box.delete(content);
  }
}
