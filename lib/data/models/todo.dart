import 'package:hive_flutter/adapters.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class ToDo {
  @HiveField(0)
  String title;
  @HiveField(1)
  String content;
  ToDo(this.title, this.content);
}
