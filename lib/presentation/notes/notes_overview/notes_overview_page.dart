import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddd_firebase/application/auth/sign_out/auth_bloc.dart';
import 'package:flutter_ddd_firebase/application/notes/note_actor/note_actor_bloc.dart';
import 'package:flutter_ddd_firebase/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:flutter_ddd_firebase/injection.dart';

class NotesOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(const NoteWatcherEvent.watchAllStarted()),
        ),
        BlocProvider<NoteActorBloc>(
          create: (context) => getIt<NoteActorBloc>(),
        )
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<NoteActorBloc, NoteActorState>(
            listener: (context, state) {
              state.maybeMap(
                deleteFailure: (state) {
                  FlushbarHelper.createError(
                    message: state.noteFailure.map(
                      unexpected: (_) =>
                          "Unexpected error occured while deleting.",
                      insufficientPermission: (_) => "Insufficient permissions",
                      unableToUpdate: (_) => "",
                    ),
                    duration: const Duration(seconds: 2),
                  ).show(context);
                },
                orElse: () {},
              );
            },
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.signedOut());
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.indeterminate_check_box),
                onPressed: () {},
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // TODO: Navigate to NoteFormPage
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
