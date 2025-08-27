// lib/infrastructure/sqlite/sqlite_db.dart
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqliteDb {
  static Database? _db;

  /// Llama a esto una sola vez al iniciar la app (o usa getDb() que lo hace lazy).
  static Future<void> init() async {
    if (_db != null) return;
    // En Windows/Linux/Desktop debemos inicializar FFI
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final dbPath = await _resolveDbPath();
    _db = await databaseFactory.openDatabase(dbPath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, _) async => _createSchema(db),
          onConfigure: _onConfigure,
        ));
  }

  static Future<Database> getDb() async {
    if (_db == null) {
      await init();
    }
    return _db!;
  }

  static Future<void> _onConfigure(Database db) async {
    // Forzar claves foráneas (para borrar en cascada si lo definimos)
    await db.execute('PRAGMA foreign_keys = ON;');
  }

  static Future<String> _resolveDbPath() async {
    // 1) LOCAL por defecto (app carpeta actual)
    final baseDir = Directory.current.path;
    final localPath = p.join(baseDir, 'data');
    await Directory(localPath).create(recursive: true);
    return p.join(localPath, 'troqueles.db');

    // Si luego quieres usar unidad de red, cambia el retorno
    // por algo como: return r'\\SERVIDOR\Compartida\bd\troqueles.db';
  }

  static Future<void> _createSchema(Database db) async {
    // ---------- Tablas base ----------
    await db.execute('''
      CREATE TABLE procesos (
        id            INTEGER PRIMARY KEY AUTOINCREMENT,
        ntroquel      TEXT NOT NULL,
        fechaIngreso  TEXT NOT NULL,        -- ISO 8601
        fechaEstimada TEXT,                 -- ISO 8601
        planta        TEXT NOT NULL,
        cliente       TEXT NOT NULL,
        maquina       TEXT NOT NULL,
        ingeniero     TEXT NOT NULL,
        observaciones TEXT NOT NULL,
        estado        TEXT NOT NULL         -- 'suspendido' | 'enProceso' | 'completado' | 'pendiente'
      );
    ''');

    await db.execute('''
      CREATE INDEX idx_procesos_ntroquel ON procesos(ntroquel);
    ''');

    await db.execute('''
      CREATE TABLE tiempos (
        id        INTEGER PRIMARY KEY AUTOINCREMENT,
        fecha     TEXT NOT NULL,           -- ISO (string)
        ntroquel  TEXT NOT NULL,
        operarios TEXT,
        ficha     TEXT,
        tiempo    REAL NOT NULL,
        actividad TEXT NOT NULL            -- enum name
      );
    ''');

    await db.execute('''
      CREATE INDEX idx_tiempos_ntroquel ON tiempos(ntroquel);
    ''');

    await db.execute('''
      CREATE TABLE materiales (
        id          INTEGER PRIMARY KEY AUTOINCREMENT,
        codigo      INTEGER NOT NULL UNIQUE,
        unidad      TEXT NOT NULL,         -- enum name
        descripcion TEXT NOT NULL,
        tipo        TEXT NOT NULL,         -- enum name
        conversion  REAL NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE consumos (
        id        INTEGER PRIMARY KEY AUTOINCREMENT,
        planta    TEXT NOT NULL,
        nTroquel  TEXT NOT NULL,
        cliente   TEXT NOT NULL,
        tipo      TEXT NOT NULL,           -- texto libre (cuchillas, escores, etc.)
        cantidad  INTEGER NOT NULL
      );
    ''');

    // Relación N:M consumo <-> materiales (por código)
    await db.execute('''
      CREATE TABLE consumo_material (
        consumo_id  INTEGER NOT NULL,
        material_id INTEGER NOT NULL,
        PRIMARY KEY (consumo_id, material_id),
        FOREIGN KEY(consumo_id) REFERENCES consumos(id) ON DELETE CASCADE,
        FOREIGN KEY(material_id) REFERENCES materiales(id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE operarios (
        id     INTEGER PRIMARY KEY AUTOINCREMENT,
        ficha  INTEGER NOT NULL,
        nombre TEXT NOT NULL
      );
    ''');
  }
}
