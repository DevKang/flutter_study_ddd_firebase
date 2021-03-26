import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddd_firebase/application/notes/note_form/note_form_bloc.dart';
import 'package:flutter_ddd_firebase/domain/notes/todo_item.dart';
import 'package:flutter_ddd_firebase/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_ddd_firebase/presentation/notes/note_form/misc/build_context_x.dart';
import 'package:kt_dart/collection.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (p, c) => p.note.todos.isFull != c.note.todos.isFull,
      listener: (context, state) {
        if (state.note.todos.isFull) {
          FlushbarHelper.createAction(
            message: "Want Longerlists? Active premium",
            button: const CupertinoButton(
              onPressed: null,
              child: Text(
                "But Now",
                style: TextStyle(color: Colors.yellow),
              ),
            ),
          ).show(context);
        }
      },
      child: Consumer<FormTodos>(builder: (context, formTodos, child) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: formTodos.value.size,
          itemBuilder: (context, index) {
            return TodoTile(index: index);
          },
        );
      }),
    );
  }
}

class TodoTile extends HookWidget {
  final int index;

  const TodoTile({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final todo =
        context.formTodos.getOrElse(index, (_) => TodoItemPrimitive.empty());

    return ListTile(
      leading: Checkbox(
        value: todo.done,
        onChanged: (value) {
          context.formTodos = context.formTodos.map(
            (listTodo) => listTodo == todo
                ? todo.copyWith(done: value ?? false)
                : listTodo,
          );
          context
              .read<NoteFormBloc>()
              .add(NoteFormEvent.todosChanged(context.formTodos));
        },
      ),
    );
  }
}