import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_list/data/models/todo.dart';
import 'package:to_do_list/features/todolist/domain/useCases/add_note_usecase.dart';
import 'package:to_do_list/features/todolist/domain/useCases/delete_note_usecase.dart';
import 'package:to_do_list/features/todolist/domain/useCases/get_notes_usecase.dart';
import 'package:to_do_list/features/todolist/presentation/bloc/get_notes_event.dart';
import 'package:to_do_list/features/todolist/presentation/bloc/get_notes_state.dart';

class GetNotesBloc extends Bloc<GetNotesEvent, GetNotesState> {
  GetNotesBloc() : super(GetNotesInitial()) {
    on<GetNotes>((event, emit) async {
      emit(GetNotesLoading());
      final list = await GetIt.I<GetNotesUseCase>().getNotes();
      emit(GetNotesLoaded(list));
    });
    on<AddNote>((event, emit) {
      final toDo = ToDo(event.title, event.content);
      GetIt.I<AddNoteUseCase>().addNote(toDo);
      add(GetNotes());
    });

    on<DeleteNote>((event, emit) {
      GetIt.I<DeleteNoteUseCase>().deleteNote(event.content);
      add(GetNotes());
    });
  }
}
