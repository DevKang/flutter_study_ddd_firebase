import 'package:dartz/dartz.dart';
import 'package:flutter_ddd_firebase/domain/notes/note.dart';
import 'package:flutter_ddd_firebase/domain/notes/note_failure.dart';
import 'package:kt_dart/collection.dart';

abstract class INoteRepository {
  // watch notes
  Stream<Either<NoteFailure, KtList<Note>>> watchAll();
  // watch uncompleted notes
  Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted();
  // create / update / delete
  Future<Either<NoteFailure, Unit>> create(Note note);
  Future<Either<NoteFailure, Unit>> update(Note note);
  Future<Either<NoteFailure, Unit>> delete(Note note);
}
