// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorFlutterDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder databaseBuilder(String name) =>
      _$FlutterDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FlutterDatabaseBuilder(null);
}

class _$FlutterDatabaseBuilder {
  _$FlutterDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FlutterDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FlutterDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FlutterDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FlutterDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FlutterDatabase extends FlutterDatabase {
  _$FlutterDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PlantDao? _plantDaoInstance;

  PlantTypeDao? _plantTypeDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `Plant` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `date` TEXT NOT NULL, `type` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PlantType` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `type` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PlantDao get plantDao {
    return _plantDaoInstance ??= _$PlantDao(database, changeListener);
  }

  @override
  PlantTypeDao get plantTypeDao {
    return _plantTypeDaoInstance ??= _$PlantTypeDao(database, changeListener);
  }
}

class _$PlantDao extends PlantDao {
  _$PlantDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _plantInsertionAdapter = InsertionAdapter(
            database,
            'Plant',
            (Plant item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'type': item.type
                }),
        _plantUpdateAdapter = UpdateAdapter(
            database,
            'Plant',
            ['id'],
            (Plant item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'type': item.type
                }),
        _plantDeletionAdapter = DeletionAdapter(
            database,
            'Plant',
            ['id'],
            (Plant item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'type': item.type
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Plant> _plantInsertionAdapter;

  final UpdateAdapter<Plant> _plantUpdateAdapter;

  final DeletionAdapter<Plant> _plantDeletionAdapter;

  @override
  Future<List<Plant>> getPlants() async {
    return _queryAdapter.queryList('SELECT * FROM Plant',
        mapper: (Map<String, Object?> row) => Plant(
            row['id'] as int?,
            row['name'] as String,
            row['date'] as String,
            row['type'] as String));
  }

  @override
  Future<void> insertPlant(Plant plant) async {
    await _plantInsertionAdapter.insert(plant, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePlant(Plant plant) async {
    await _plantUpdateAdapter.update(plant, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePlant(Plant plant) async {
    await _plantDeletionAdapter.delete(plant);
  }
}

class _$PlantTypeDao extends PlantTypeDao {
  _$PlantTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _plantTypeInsertionAdapter = InsertionAdapter(
            database,
            'PlantType',
            (PlantType item) =>
                <String, Object?>{'id': item.id, 'type': item.type});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PlantType> _plantTypeInsertionAdapter;

  @override
  Future<List<PlantType>> getAllPlantTypes() async {
    return _queryAdapter.queryList('SELECT * FROM PlantType',
        mapper: (Map<String, Object?> row) =>
            PlantType(row['id'] as int?, row['type'] as String));
  }

  @override
  Future<void> insertPlantType(PlantType plantType) async {
    await _plantTypeInsertionAdapter.insert(
        plantType, OnConflictStrategy.abort);
  }
}
