import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list/data/local_data_source/db_methods.dart';
import 'package:to_do_list/data/models/todo.dart';
import 'package:to_do_list/data/repo_impl/dbrepo_impl.dart';
import 'package:to_do_list/features/todolist/domain/repos/dbrepo.dart';
import 'package:to_do_list/features/todolist/domain/useCases/add_note_usecase.dart';
import 'package:to_do_list/features/todolist/domain/useCases/delete_note_usecase.dart';
import 'package:to_do_list/features/todolist/domain/useCases/get_notes_usecase.dart';
import 'package:to_do_list/features/todolist/domain/useCases/update_note_usecase.dart';

import 'package:to_do_list/features/todolist/presentation/screens/home_screen.dart';
import 'package:to_do_list/theme/main_theme.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  Box<ToDo> todos_box = await Hive.openBox('todo_box');
  GetIt.I.registerSingleton<DbMethods>(DbMethodsImpl(todos_box));
  GetIt.I.registerSingleton<DbRepo>(DbRepoImpl());
  GetIt.I.registerSingleton(AddNoteUseCase());
  GetIt.I.registerSingleton(DeleteNoteUseCase());
  GetIt.I.registerSingleton(GetNotesUseCase());
  GetIt.I.registerSingleton(UpdateNoteUseCase());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: main_theme,
        title: 'To Do List',
        home: HomeScreen());
  }
}
