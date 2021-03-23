import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ddd_firebase/domain/notes/i_note_repository.dart';
import 'package:flutter_ddd_firebase/domain/notes/note.dart';
import 'package:flutter_ddd_firebase/domain/notes/note_failure.dart';
import 'package:flutter_ddd_firebase/domain/notes/value_objects.dart';
import 'package:flutter_ddd_firebase/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';

part 'note_form_event.dart';
part 'note_form_state.dart';
part 'note_form_bloc.freezed.dart';

@Injectable()
class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  final INoteRepository _noteRepository;

  NoteFormBloc(this._noteRepository) : super(NoteFormState.initial());

  @override
  Stream<NoteFormState> mapEventToState(
    NoteFormEvent event,
  ) async* {
    yield* event.map(
      initialized: (e) async* {
        if (e.initialNote == null) {
          yield state;
        } else {
          yield state.copyWith(
            note: e.initialNote!,
            isEditing: true,
          );
        }
      },
      bodyChanged: (e) async* {
        yield state.copyWith(
          note: state.note.copyWith(body: NoteBody(e.bodyStr)),
          saveFailureOrSuccess: null,
        );
      },
      colorChanged: (e) async* {
        yield state.copyWith(
          note: state.note.copyWith(color: NoteColor(e.color)),
          saveFailureOrSuccess: null,
        );
      },
      todosChanged: (e) async* {
        yield state.copyWith(
          note: state.note.copyWith(
            todos: List3(e.todos.map((primitive) => primitive.toDomain())),
          ),
          saveFailureOrSuccess: null,
        );
      },
      saved: (e) async* {
        Either<NoteFailure, Unit>? failureOrSuccess;
        yield state.copyWith(
          isSaving: true,
          saveFailureOrSuccess: null,
        );

        if (state.note.failureOption == null) {
          failureOrSuccess = state.isEditing
              ? await _noteRepository.update(state.note)
              : await _noteRepository.create(state.note);

          yield state.copyWith(
            isSaving: false,
            showErrorMessages: true,
            saveFailureOrSuccess: failureOrSuccess,
          );
        } else {
          yield state.copyWith(
            isSaving: false,
            showErrorMessages: true,
          );
        }
      },
    );
  }
}
