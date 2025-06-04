// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao? _noteDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `note` (`id` INTEGER, `title` TEXT, `content` TEXT, `createdAt` INTEGER NOT NULL, `updatedAt` INTEGER NOT NULL, `status` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _noteModelsInsertionAdapter = InsertionAdapter(
            database,
            'note',
            (NoteModels item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'createdAt': _dateTimeConverter.encode(item.createdAt),
                  'updatedAt': _dateTimeConverter.encode(item.updatedAt),
                  'status': item.status
                }),
        _noteModelsDeletetionAdapter = DeletionAdapter(
            database,
            'note',
            ['id'],
            (NoteModels item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'createdAt': _dateTimeConverter.encode(item.createdAt),
                  'updatedAt': _dateTimeConverter.encode(item.updatedAt),
                  'status': item.status
                }),
        _noteModelsUpdateAdapter = UpdateAdapter(
            database,
            'note',
            ['id'],
            (NoteModels item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'createdAt': _dateTimeConverter.encode(item.createdAt),
                  'updatedAt': _dateTimeConverter.encode(item.updatedAt),
                  'status': item.status
                });
        

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NoteModels> _noteModelsInsertionAdapter;

  final DeletionAdapter<NoteModels> _noteModelsDeletetionAdapter;

  final UpdateAdapter<NoteModels> _noteModelsUpdateAdapter;

  @override
  Future<List<NoteModels>> getNoteByStatus(String status) async {
    return _queryAdapter.queryList('SELECT * FROM note WHERE status = ?1',
        mapper: (Map<String, Object?> row) => NoteModels(
            id: row['id'] as int?,
            title: row['title'] as String?,
            content: row['content'] as String?,
            createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
            updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
            status: row['status'] as String?),
        arguments: [status]);
  }

  @override
  Future<void> deleteNote(NoteModels note) async {
    await _noteModelsDeletetionAdapter.delete(note);
  }
  
  @override
  Future<void> insertNote(NoteModels note) async{
    await _noteModelsInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }
  
  @override
  Future<void> updateNote(NoteModels note) async{
    await _noteModelsUpdateAdapter.update(note, OnConflictStrategy.abort);
  }
  
  @override
  Future<NoteModels?> getNoteById(int id) async {
    return _queryAdapter.query(
      'SELECT * FROM note WHERE id = ?1',
      mapper: (Map<String, Object?> row) => NoteModels(
        id: row['id'] as int?,
        title: row['title'] as String?,
        content: row['content'] as String?,
        createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
        updatedAt: _dateTimeConverter.decode(row['updatedAt'] as int),
        status: row['status'] as String?,
      ),
      arguments: [id],
    );
  }

}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
