import 'package:to_do_list/data/models/todo.dart';

abstract class GetNotesState {}

class GetNotesInitial extends GetNotesState {}

class GetNotesLoading extends GetNotesState {}

class GetNotesLoaded extends GetNotesState {
  List<ToDo> note_list;
  GetNotesLoaded(this.note_list);
}
