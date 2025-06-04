import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final int? id;
  final String? title;
  final String? content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? status;

  const NoteEntity({
    this.id,
    this.title,
    this.content,
    required this.createdAt,
    required this.updatedAt,
    this.status,
  });

  @override
  List<Object?> get props => [id, title, content, createdAt, updatedAt, status];

  NoteEntity copyWith({
  int? id,
  String? title,
  String? content,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? status,
}) {
  return NoteEntity(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    status: status ?? this.status,
  );
}

}