import 'package:get_it/get_it.dart';
import 'package:to_do_list/data/models/todo.dart';
import 'package:to_do_list/features/todolist/domain/repos/dbrepo.dart';

class DeleteNoteUseCase {
  deleteNote(String content) {
    GetIt.I<DbRepo>().deleteNote(content);
  }
}
