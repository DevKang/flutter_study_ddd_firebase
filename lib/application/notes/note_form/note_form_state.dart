part of 'note_form_bloc.dart';

@freezed
abstract class NoteFormState with _$NoteFormState {
  const factory NoteFormState({
    required Note note,
    required bool showErrorMessages,
    required bool isEditing,
    required bool isSaving,
    required Either<NoteFailure, Unit>? saveFailureOrSuccess,
  }) = _NoteFormState;

  factory NoteFormState.initial() => NoteFormState(
        note: Note.empty(),
        showErrorMessages: false,
        isEditing: false,
        isSaving: false,
        saveFailureOrSuccess: null,
      );
}
