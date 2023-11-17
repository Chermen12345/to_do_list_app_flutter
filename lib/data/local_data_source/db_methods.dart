import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list/data/models/todo.dart';

abstract class DbMethods {
  addToDo(ToDo toDo);
  deleteToDo(int index);
  updateToDo(int index, ToDo toDo);
  Future<List<ToDo>> getToDos();
}

class DbMethodsImpl implements DbMethods {
  Box<ToDo> todos_box;
  DbMethodsImpl(this.todos_box);
  @override
  addToDo(ToDo toDo) {
    // TODO: implement addToDo
    todos_box.add(toDo);
  }

  @override
  Future<List<ToDo>> getToDos() async {
    // TODO: implement getToDos
    final todo_list = todos_box.values.toList();
    return todo_list;
  }

  @override
  deleteToDo(int index) {
    // TODO: implement deleteToDo
    todos_box.deleteAt(index);
  }

  @override
  updateToDo(int index, ToDo toDo) {
    // TODO: implement updateToDo
    todos_box.putAt(index, toDo);
  }
}
