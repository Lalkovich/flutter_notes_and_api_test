import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/hive/hive_notes_service.dart';
import '../../../data/model/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_screen_event.dart';

part 'list_screen_state.dart';

class ListScreenBloc extends Bloc<ListScreenEvent, ListScreenState> {
  final HiveNotesService noteService;

  ListScreenBloc({required this.noteService}) : super(ListScreenInitial()) {
    on<GetAllNotesEvent>(_getAllNotesEvent);
    on<CreateNewNoteEvent>(_addNoteEvent);
    on<DeleteNoteEvent>(_deleteNoteEvent);
    on<EditNoteEvent>(_editNoteEvent);
    on<SearchNoteEvent>(_searchNoteEvent);
    on<FilterByEvent>(_filterByEvent);
  }

  void _addNoteEvent(
      CreateNewNoteEvent event, Emitter<ListScreenState> emit) async {
    emit(AddNoteState());
    try {
      await noteService.addNoteToBox(event.model);
      emit(NoteIsAddedState());
    } catch (e) {
      emit(NoteListError(message: e.toString()));
    }
  }

  void _deleteNoteEvent(
      DeleteNoteEvent event, Emitter<ListScreenState> emit) async {
    try {
      await noteService.deleteNoteFromBox(event.id);
      final result = await noteService.getAllNotesFromBox();

      if (result.isEmpty) {
        emit(ListScreenIsEmpty(noteList: const []));
      } else {
        emit(ListScreenIsLoaded(noteList: result));
      }
    } catch (e) {
      emit(NoteListError(message: e.toString()));
    }
  }

  void _getAllNotesEvent(
      GetAllNotesEvent event, Emitter<ListScreenState> emit) async {
    emit(ListScreenIsLoading());
    try {
      final result = await noteService.getAllNotesFromBox();
      if (result.isEmpty) {
        emit(ListScreenIsEmpty(noteList: const []));
      } else {
        emit(ListScreenIsLoaded(noteList: result));
      }
    } catch (e) {
      emit(NoteListError(message: e.toString()));
    }
  }

  void _editNoteEvent(
      EditNoteEvent event, Emitter<ListScreenState> emit) async {
    emit(EditNoteState());
    try {
      await noteService.editNoteInBox(event.model);
      final result = await noteService.getAllNotesFromBox();
      emit(ListScreenIsLoaded(noteList: result));
    } catch (e) {
      emit(NoteListError(message: e.toString()));
    }
  }

  void _searchNoteEvent(
      SearchNoteEvent event, Emitter<ListScreenState> emit) async {
    emit(ListScreenIsLoading());
    try {
      final result = await noteService.searchNotes(event.keywords);
      if (result.isEmpty) {
        emit(NoteNotFound());
      } else {
        emit(ListScreenIsLoaded(noteList: result));
      }
    } catch (e) {
      emit(NoteListError(message: e.toString()));
    }
  }

  void _filterByEvent(
      FilterByEvent event, Emitter<ListScreenState> emit) async {
    emit(ListScreenIsLoading());
    try {
      final result =
          await noteService.filterBy(event.category, event.isFinished);
      if (result.isEmpty) {
        emit(NoteNotFound());
      } else {
        emit(ListScreenIsLoaded(noteList: result));
      }
    } catch (e) {
      emit(NoteListError(message: e.toString()));
    }
  }
}
