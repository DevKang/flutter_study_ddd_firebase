import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ddd_firebase/domain/core/value_objects.dart';
import 'package:flutter_ddd_firebase/domain/notes/note.dart';
import 'package:flutter_ddd_firebase/domain/notes/todo_item.dart';
import 'package:flutter_ddd_firebase/domain/notes/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

part 'note_dtos.freezed.dart';
part 'note_dtos.g.dart';

@freezed
abstract class NoteDto implements _$NoteDto {
  const factory NoteDto({
    @JsonKey(ignore: true) String? id,
    required String body,
    required int color,
    required List<TodoItemDto> todos,
    @ServerTimestampConverter() required FieldValue serverTimeStamp,
  }) = _NoteDto;

  const NoteDto._();

  factory NoteDto.fromJson(Map<String, dynamic> json) =>
      _$NoteDtoFromJson(json);

  factory NoteDto.fromFirestore(DocumentSnapshot doc) {
    return NoteDto.fromJson(doc.data()!).copyWith(id: doc.id);
  }

  factory NoteDto.fromDomain(Note note) {
    return NoteDto(
      id: note.id.getOrCrash(),
      body: note.body.getOrCrash(),
      color: note.color.getOrCrash().value,
      todos: note.todos
          .getOrCrash()
          .map((item) => TodoItemDto.fromDomain(item))
          .asList(),
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  Note toDomain() {
    return Note(
      id: id != null ? UniqueId.fromUniqueString(id!) : UniqueId(),
      body: NoteBody(body),
      color: NoteColor(Color(color)),
      todos: List3(
        todos.map((dto) => dto.toDomain()).toImmutableList(),
      ),
    );
  }
}

class ServerTimestampConverter implements JsonConverter<FieldValue, Object> {
  const ServerTimestampConverter();

  @override
  FieldValue fromJson(json) {
    return FieldValue.serverTimestamp();
  }

  @override
  Object toJson(object) => object;
}

@freezed
abstract class TodoItemDto implements _$TodoItemDto {
  const factory TodoItemDto({
    required String id,
    required String name,
    required bool done,
  }) = _TodoItemDto;

  const TodoItemDto._();

  factory TodoItemDto.fromDomain(TodoItem item) {
    return TodoItemDto(
      id: item.id.getOrCrash(),
      name: item.name.getOrCrash(),
      done: item.done,
    );
  }

  factory TodoItemDto.fromJson(Map<String, dynamic> json) =>
      _$TodoItemDtoFromJson(json);

  TodoItem toDomain() {
    return TodoItem(
      id: UniqueId.fromUniqueString(id),
      name: TodoName(name),
      done: done,
    );
  }
}
