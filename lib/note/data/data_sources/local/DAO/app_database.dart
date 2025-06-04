import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_application_drag_and_drop/core/util/converters/date_time_converter.dart';
import 'package:flutter_application_drag_and_drop/note/data/data_sources/local/DAO/note_dao.dart';
import 'package:flutter_application_drag_and_drop/note/data/models/note.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [NoteModels])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;

}