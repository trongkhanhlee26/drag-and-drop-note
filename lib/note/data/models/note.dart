import 'package:floor/floor.dart';
import 'package:flutter_application_drag_and_drop/core/util/converters/date_time_converter.dart';
import 'package:flutter_application_drag_and_drop/note/domain/entities/note.dart';

@Entity(tableName: 'note')
@TypeConverters([DateTimeConverter])
class NoteModels {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? title;
  final String? content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? status;

  const NoteModels({
    this.id,
    this.title,
    this.content,
    required this.createdAt,
    required this.updatedAt,
    this.status,
  });

  factory NoteModels.fromJson(Map<String, dynamic> json) {
    return NoteModels(
      title: json['title'] as String?,
      content: json['content'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String? ?? '',
    );
  }
  
  factory NoteModels.fromEntity(NoteEntity entity) {
    return NoteModels(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      status: entity.status,
    );
  }
  NoteEntity toEntity() {
    return NoteEntity(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
    );
  }
}