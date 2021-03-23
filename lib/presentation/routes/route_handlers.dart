import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ddd_firebase/domain/notes/note.dart';
import 'package:flutter_ddd_firebase/presentation/notes/note_form/note_form_page.dart';
import 'package:flutter_ddd_firebase/presentation/notes/notes_overview/notes_overview_page.dart';
import 'package:flutter_ddd_firebase/presentation/sign_in/sign_in_page.dart';
import 'package:flutter_ddd_firebase/presentation/splash/splash_page.dart';

Handler splashRouteHandler = Handler(handlerFunc: (
  BuildContext? context,
  Map<String, List<String>> params,
) {
  return SplashPage();
});

Handler signInRouteHandler = Handler(handlerFunc: (
  BuildContext? context,
  Map<String, List<String>> params,
) {
  return SignInPage();
});

Handler notesOverviewRouteHandler = Handler(handlerFunc: (
  BuildContext? context,
  Map<String, List<String>> params,
) {
  return NotesOverviewPage();
});

Handler noteFormRouteHandler = Handler(handlerFunc: (
  BuildContext? context,
  Map<String, List<String>> params,
) {
  final editedNote = context?.settings?.arguments as Note?;
  return NoteFormPage(editedNote: editedNote);
});
