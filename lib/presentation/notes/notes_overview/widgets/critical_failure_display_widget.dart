import 'package:flutter/material.dart';
import 'package:flutter_ddd_firebase/domain/notes/note_failure.dart';

class CriticalFailureDisplay extends StatelessWidget {
  final NoteFailure noteFailure;

  const CriticalFailureDisplay({
    Key? key,
    required this.noteFailure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '😱',
            style: TextStyle(fontSize: 80),
          ),
          Text(
            noteFailure.maybeMap(
              insufficientPermission: (_) => 'Insufficient permissions',
              orElse: () => 'UnexpectedError',
            ),
          )
        ],
      ),
    );
  }
}
