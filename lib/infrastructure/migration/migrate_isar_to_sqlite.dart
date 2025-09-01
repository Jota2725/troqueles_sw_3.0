// lib/infrastructure/migration/migrate_isar_to_sqlite.dart
import 'package:isar/isar.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../domain/entities/consumo.dart';
import '../../domain/entities/materiales.dart';
import '../../domain/entities/proceso.dart';
import '../../domain/entities/tiempos.dart';
import '../datasource/sqlite/sqlite_db.dart';

// NEW: usamos tu datasource para abrir la DB de Isar con sus schemas y la ruta correcta
import '../datasource/isar_datasource.dart' as isar_ds;

class IsarToSqliteMigrator {
  static Future<void> migrate({bool force = false, bool wipe = false}) async {
    final sqlite = await SqliteDb.getDb();

    // ¿SQLite ya tiene datos?
    final existing = await _sqliteCounts(sqlite);
    final hasAny = existing.any((n) => n > 0);
    if (hasAny && !force) return;

    if (hasAny && force && wipe) {
      await _wipeSqlite(sqlite);
    }

    // --- Abrir ISAR si aún no está abierto (¡clave!) ---
    await _ensureIsarOpen(); // NEW

    final isar = Isar.getInstance();
    if (isar == null) {
      // No hay datos de ISAR disponibles; nada que migrar
      return;
    }

    final procesos = await isar.procesos.where().findAll();
    final tiempos = await isar.tiempos.where().findAll();
    final materiales = await isar.materiales.where().findAll();
    final consumos = await isar.consumos.where().findAll();

    await sqlite.transaction((txn) async {
      // procesos
      for (final p in procesos) {
        await txn.insert(
            'procesos',
            {
              'id': p.isarId,
              'ntroquel': p.ntroquel,
              'fechaIngreso': p.fechaIngreso.toIso8601String(),
              'fechaEstimada': p.fechaEstimada?.toIso8601String(),
              'planta': p.planta,
              'cliente': p.cliente,
              'maquina': p.maquina,
              'ingeniero': p.ingeniero,
              'observaciones': p.observaciones,
              'estado': p.estado.name,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      // materiales
      for (final m in materiales) {
        await txn.insert(
            'materiales',
            {
              'id': m.isarId,
              'codigo': m.codigo,
              'unidad': m.unidad.name,
              'descripcion': m.descripcion,
              'tipo': m.tipo.name,
              'conversion': m.conversion,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      // consumos + vínculos por código
      for (final c in consumos) {
        final newId = await txn.insert(
            'consumos',
            {
              'id': c.isarid,
              'planta': c.planta,
              'nTroquel': c.nTroquel,
              'cliente': c.cliente,
              'tipo': c.tipo,
              'cantidad': c.cantidad,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);

        final mats = await c.materiales.filter().findAll();
        for (final mat in mats) {
          final mRow = await txn.query('materiales',
              where: 'codigo = ?', whereArgs: [mat.codigo], limit: 1);
          if (mRow.isNotEmpty) {
            await txn.insert(
                'consumo_material',
                {
                  'consumo_id': newId,
                  'material_id': mRow.first['id'] as int,
                },
                conflictAlgorithm: ConflictAlgorithm.ignore);
          }
        }
      }

      // tiempos
      for (final t in tiempos) {
        await txn.insert(
            'tiempos',
            {
              'id': t.isarId,
              'fecha': t.fecha,
              'ntroquel': t.ntroquel,
              'operarios': t.operarios,
              'ficha': t.ficha,
              'tiempo': t.tiempo,
              'actividad': t.actividad.name,
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  static Future<void> _ensureIsarOpen() async {
    // Si ya está abierta, no hacemos nada
    if (Isar.instanceNames.isNotEmpty) return;
    // Usa tu IsarDatasource para abrir con los schemas y directorio correctos
    final ds = isar_ds.IsarDatasource();
    await ds.openDB(); // abre (si no está abierto)
  }

  static Future<List<int>> _sqliteCounts(Database db) async {
    final tables = [
      'procesos',
      'tiempos',
      'materiales',
      'consumos',
      'operarios'
    ];
    final out = <int>[];
    for (final t in tables) {
      final r = await db.rawQuery('SELECT COUNT(*) as cnt FROM $t');
      out.add((r.first['cnt'] as int?) ?? 0);
    }
    return out;
  }

  static Future<void> _wipeSqlite(Database db) async {
    await db.transaction((txn) async {
      await txn.delete('consumo_material');
      await txn.delete('consumos');
      await txn.delete('tiempos');
      await txn.delete('materiales');
      await txn.delete('operarios');
      await txn.delete('procesos');
    });
  }
}
