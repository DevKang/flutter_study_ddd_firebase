import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddd_firebase/application/notes/note_actor/note_actor_bloc.dart';
import 'package:flutter_ddd_firebase/domain/notes/note.dart';
import 'package:flutter_ddd_firebase/domain/notes/todo_item.dart';
import 'package:flutter_ddd_firebase/presentation/routes/application.dart';
import 'package:kt_dart/kt.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({
    Key? key,
    required this.note,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: note.color.getOrCrash(),
      child: InkWell(
        onTap: () {
          Application.router?.navigateTo(
            context,
            '/note_form_page',
            routeSettings: RouteSettings(arguments: note),
          );
        },
        onLongPress: () =>
            _showDeletionDialog(context, context.read<NoteActorBloc>()),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.body.getOrCrash(),
                style: const TextStyle(fontSize: 18),
              ),
              if (note.todos.length > 0) ...[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  children: [
                    ...note.todos
                        .getOrCrash()
                        .map(
                          (todoItem) => TodoDisplay(todoItem: todoItem),
                        )
                        .iter
                  ],
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  void _showDeletionDialog(BuildContext context, NoteActorBloc noteActorBloc) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Selected Note'),
            content: Text(
              note.body.getOrCrash(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              CupertinoButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              CupertinoButton(
                onPressed: () {
                  noteActorBloc.add(NoteActorEvent.deleted(note));
                  Navigator.pop(context);
                },
                child: const Text('Delete this note'),
              ),
            ],
          );
        });
  }
}

class TodoDisplay extends StatelessWidget {
  final TodoItem todoItem;

  const TodoDisplay({
    Key? key,
    required this.todoItem,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (todoItem.done)
          Icon(
            Icons.check_box,
            color: Theme.of(context).accentColor,
          ),
        if (!todoItem.done)
          Icon(
            Icons.check_box_outline_blank,
            color: Theme.of(context).disabledColor,
          ),
        Text(todoItem.name.getOrCrash())
      ],
    );
  }
}
