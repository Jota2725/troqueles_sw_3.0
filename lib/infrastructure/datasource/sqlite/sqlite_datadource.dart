// lib/infrastructure/sqlite/sqlite_datasource.dart
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../domain/entities/proceso.dart';
import '../../../domain/entities/tiempos.dart';
import '../../../domain/entities/materiales.dart';
import '../../../domain/entities/consumo.dart';
import '../../../domain/entities/operario.dart';
import '../../../domain/entities/general_info.dart';
import 'sqlite_db.dart';

String _estadoToStr(Estado e) => e.name;
Estado _estadoFromStr(String s) => Estado.values
    .firstWhere((e) => e.name == s, orElse: () => Estado.pendiente);

String _actividadToStr(Actividad a) => a.name;
Actividad _actividadFromStr(String s) => Actividad.values.firstWhere(
      (e) => e.name == s,
      orElse: () => Actividad.Dibujo,
    );

String _unidadToStr(Unidad u) => u.name;
Unidad _unidadFromStr(String s) =>
    Unidad.values.firstWhere((e) => e.name == s, orElse: () => Unidad.und);

String _tipoToStr(Tipo t) => t.name;
Tipo _tipoFromStr(String s) =>
    Tipo.values.firstWhere((e) => e.name == s, orElse: () => Tipo.herramientas);

class SqliteDatasource {
  // --------------------------- PROCESOS ---------------------------

  Future<List<Proceso>> getAllTroquelesInProcess() async {
    final db = await SqliteDb.getDb();
    final rows = await db.query('procesos', orderBy: 'id DESC');
    return rows.map(_procesoFromMap).toList();
  }

  Future<List<Proceso>> getTroquelesByEstado(Estado estado) async {
    final db = await SqliteDb.getDb();
    final rows = await db.query('procesos',
        where: 'estado = ?',
        whereArgs: [_estadoToStr(estado)],
        orderBy: 'id DESC');
    return rows.map(_procesoFromMap).toList();
  }

  Future<Proceso?> getTroquelInProcess(String ntroquel) async {
    final db = await SqliteDb.getDb();
    final rows = await db.query('procesos',
        where: 'ntroquel = ?', whereArgs: [ntroquel], limit: 1);
    if (rows.isEmpty) return null;
    return _procesoFromMap(rows.first);
  }

  Future<void> addNewTroquelInProcess(List<Proceso> procesos) async {
    final db = await SqliteDb.getDb();
    final batch = db.batch();
    for (final p in procesos) {
      batch.insert('procesos', _procesoToMap(p));
    }
    await batch.commit(noResult: true);
  }

  Future<void> updatedTroquelInProcess(Proceso p) async {
    final db = await SqliteDb.getDb();
    await db.update('procesos', _procesoToMap(p),
        where: 'id = ?', whereArgs: [p.isarId]);
  }

  Future<void> deleteTroquelInProcees(int id) async {
    final db = await SqliteDb.getDb();
    await db.delete('procesos', where: 'id = ?', whereArgs: [id]);
  }

  // --------------------------- TIEMPOS ---------------------------

  Future<List<Tiempos>> getAllTiempos() async {
    final db = await SqliteDb.getDb();
    final rows = await db.query('tiempos', orderBy: 'id DESC');
    return rows.map(_tiempoFromMap).toList();
  }

  Future<void> addNewTiempo(List<Tiempos> tiempos) async {
    final db = await SqliteDb.getDb();
    final batch = db.batch();
    for (final t in tiempos) {
      batch.insert('tiempos', _tiempoToMap(t));
    }
    await batch.commit(noResult: true);
  }

  Future<void> uptadeTime(Tiempos t) async {
    final db = await SqliteDb.getDb();
    await db.update('tiempos', _tiempoToMap(t),
        where: 'id = ?', whereArgs: [t.isarId]);
  }

  Future<void> deleteTiempos(int id) async {
    final db = await SqliteDb.getDb();
    await db.delete('tiempos', where: 'id = ?', whereArgs: [id]);
  }

  // --------------------------- MATERIALES ---------------------------

  Future<List<Materiales>> gettAllMateriles() async {
    final db = await SqliteDb.getDb();
    final rows = await db.query('materiales', orderBy: 'codigo ASC');
    return rows.map(_materialFromMap).toList();
  }

  Future<void> addNewMaterial(List<Materiales> materiales) async {
    final db = await SqliteDb.getDb();
    final batch = db.batch();
    for (final m in materiales) {
      batch.insert('materiales', _materialToMap(m),
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    await batch.commit(noResult: true);
  }

  Future<void> deleteMaterialById(int id) async {
    final db = await SqliteDb.getDb();
    await db.delete('materiales', where: 'id = ?', whereArgs: [id]);
  }

  // --------------------------- CONSUMOS ---------------------------

  Future<List<Consumo>> getAllConsumos() async {
    final db = await SqliteDb.getDb();
    final rows = await db.query('consumos', orderBy: 'id DESC');

    // Cargar relaciones N:M (materiales)
    final result = <Consumo>[];
    for (final r in rows) {
      final consumo = _consumoFromMap(r);
      final mats = await db.rawQuery('''
        SELECT m.*
        FROM materiales m
        JOIN consumo_material cm ON cm.material_id = m.id
        WHERE cm.consumo_id = ?
      ''', [consumo.isarid]);

      final materiales = mats.map(_materialFromMap).toList();

      // recrear el objeto con links "resueltos" (sin IsarLinks)
      // para mantener tu API, devolvemos Consumo y el UI usa .materiales.add()
      // pero aquí no existe IsarLinks; así que devolvemos un "mock"
      final fakeLink = _FakeIsarLinks<Materiales>(materiales);
      result.add(Consumo(
        nTroquel: consumo.nTroquel,
        planta: consumo.planta,
        cliente: consumo.cliente,
        tipo: consumo.tipo,
        cantidad: consumo.cantidad,
        materiales: fakeLink.asIsarLinks(),
      )..isarid = consumo.isarid);
    }
    return result;
  }

  Future<void> addNewConsumo(List<Consumo> consumos) async {
    final db = await SqliteDb.getDb();
    // Nota: en SQLite no tenemos IsarLinks, así que insertamos en tabla intermedia.
    await db.transaction((txn) async {
      for (final c in consumos) {
        final consumoId = await txn.insert('consumos', _consumoToMap(c));
        // Vincular materiales por codigo -> buscamos id material
        for (final m in c.materiales) {
          final mats = await txn.query('materiales',
              where: 'codigo = ?', whereArgs: [m.codigo], limit: 1);
          if (mats.isNotEmpty) {
            final materialId = mats.first['id'] as int;
            await txn.insert(
                'consumo_material',
                {
                  'consumo_id': consumoId,
                  'material_id': materialId,
                },
                conflictAlgorithm: ConflictAlgorithm.ignore);
          }
        }
      }
    });
  }

  Future<void> updateConsumo(Consumo c) async {
    final db = await SqliteDb.getDb();
    await db.transaction((txn) async {
      await txn.update('consumos', _consumoToMap(c),
          where: 'id = ?', whereArgs: [c.isarid]);
      // limpiar vínculos y reinsertar
      await txn.delete('consumo_material',
          where: 'consumo_id = ?', whereArgs: [c.isarid]);
      for (final m in c.materiales) {
        final mats = await txn.query('materiales',
            where: 'codigo = ?', whereArgs: [m.codigo], limit: 1);
        if (mats.isNotEmpty) {
          final materialId = mats.first['id'] as int;
          await txn.insert(
              'consumo_material',
              {
                'consumo_id': c.isarid,
                'material_id': materialId,
              },
              conflictAlgorithm: ConflictAlgorithm.ignore);
        }
      }
    });
  }

  Future<void> deleteConsumo(int id) async {
    final db = await SqliteDb.getDb();
    await db.transaction((txn) async {
      await txn
          .delete('consumo_material', where: 'consumo_id = ?', whereArgs: [id]);
      await txn.delete('consumos', where: 'id = ?', whereArgs: [id]);
    });
  }

  // --------------------------- OPERARIOS ---------------------------

  Future<List<Operario>> getAllOperarios() async {
    final db = await SqliteDb.getDb();
    final rows = await db.query('operarios', orderBy: 'nombre ASC');
    return rows
        .map((r) => Operario(
              ficha: (r['ficha'] as num).toInt(),
              nombre: r['nombre'] as String,
            )..isarId = (r['id'] as int))
        .toList();
  }

  Future<void> addNewOperarios(List<Operario> operarios) async {
    final db = await SqliteDb.getDb();
    final batch = db.batch();
    for (final o in operarios) {
      batch.insert('operarios', {
        'ficha': o.ficha,
        'nombre': o.nombre,
      });
    }
    await batch.commit(noResult: true);
  }

  // --------------------------- RESUMEN GENERAL ---------------------------

  Future<List<GeneralInfo>> getResumenGeneral() async {
    final db = await SqliteDb.getDb();

    // Mapear ntroquel -> cliente, planta (de procesos; el último registro)
    final procesos = await db.query('procesos', orderBy: 'id ASC');
    final meta = <String, Map<String, String>>{};
    for (final p in procesos) {
      meta[p['ntroquel'] as String] = {
        'cliente': p['cliente'] as String? ?? '',
        'planta': p['planta'] as String? ?? '',
      };
    }

    // Tiempos: sumas por actividad
    final tiemposRows = await db.rawQuery('''
      SELECT ntroquel, actividad, SUM(tiempo) AS total
      FROM tiempos
      GROUP BY ntroquel, actividad
    ''');

    final mapa = <String, GeneralInfo>{};
    for (final row in tiemposRows) {
      final n = row['ntroquel'] as String;
      final actividad = row['actividad'] as String;
      final total = (row['total'] as num).toDouble();

      final cliente = meta[n]?['cliente'] ?? '';
      final planta = meta[n]?['planta'] ?? '';

      mapa[n] = mapa[n] ??
          GeneralInfo(
            ntroquel: n,
            cliente: cliente,
            planta: planta,
            totalDibCal: 0,
            totalEncEng: 0,
            totalTiempo: 0,
            totalCuchiEsc: 0,
          );

      if (actividad == Actividad.Dibujo.name ||
          actividad == Actividad.Punteado.name ||
          actividad == Actividad.Calado.name) {
        mapa[n] = mapa[n]!.copyWith(
          totalDibCal: mapa[n]!.totalDibCal + total,
          totalTiempo: mapa[n]!.totalTiempo + total,
        );
      } else if (actividad == Actividad.Encuchillado.name ||
          actividad == Actividad.Engomado.name) {
        mapa[n] = mapa[n]!.copyWith(
          totalEncEng: mapa[n]!.totalEncEng + total,
          totalTiempo: mapa[n]!.totalTiempo + total,
        );
      } else {
        mapa[n] = mapa[n]!.copyWith(
          totalTiempo: mapa[n]!.totalTiempo + total,
        );
      }
    }

    // Consumos: sumas Cuchi/Escore (cantidad)
    final consumosRows = await db.rawQuery('''
      SELECT nTroquel, tipo, SUM(cantidad) AS total
      FROM consumos
      GROUP BY nTroquel, tipo
    ''');

    for (final row in consumosRows) {
      final n = row['nTroquel'] as String;
      final tipo = (row['tipo'] as String).toLowerCase();
      final total = (row['total'] as num).toDouble();

      if (!mapa.containsKey(n)) {
        final cliente = meta[n]?['cliente'] ?? '';
        final planta = meta[n]?['planta'] ?? '';
        mapa[n] = GeneralInfo(
          ntroquel: n,
          cliente: cliente,
          planta: planta,
          totalDibCal: 0,
          totalEncEng: 0,
          totalTiempo: 0,
          totalCuchiEsc: 0,
        );
      }
      if (tipo.contains('cuch') || tipo.contains('escor')) {
        mapa[n] = mapa[n]!.copyWith(
          totalCuchiEsc: mapa[n]!.totalCuchiEsc + total,
        );
      }
    }

    return mapa.values.toList();
  }

  // --------------------------- MAPeos ---------------------------

  Map<String, Object?> _procesoToMap(Proceso p) => {
        'id': p.isarId,
        'ntroquel': p.ntroquel,
        'fechaIngreso': p.fechaIngreso.toIso8601String(),
        'fechaEstimada': p.fechaEstimada?.toIso8601String(),
        'planta': p.planta,
        'cliente': p.cliente,
        'maquina': p.maquina,
        'ingeniero': p.ingeniero,
        'observaciones': p.observaciones,
        'estado': _estadoToStr(p.estado),
      };

  Proceso _procesoFromMap(Map<String, Object?> m) => Proceso(
        ntroquel: m['ntroquel'] as String,
        fechaIngreso: DateTime.parse(m['fechaIngreso'] as String),
        fechaEstimada: (m['fechaEstimada'] as String?) != null
            ? DateTime.parse(m['fechaEstimada'] as String)
            : null,
        planta: m['planta'] as String,
        cliente: m['cliente'] as String,
        maquina: m['maquina'] as String,
        ingeniero: m['ingeniero'] as String,
        observaciones: m['observaciones'] as String,
        estado: _estadoFromStr(m['estado'] as String),
      )..isarId = (m['id'] as int);

  Map<String, Object?> _tiempoToMap(Tiempos t) => {
        'id': t.isarId,
        'fecha': t.fecha,
        'ntroquel': t.ntroquel,
        'operarios': t.operarios,
        'ficha': t.ficha,
        'tiempo': t.tiempo,
        'actividad': _actividadToStr(t.actividad),
      };

  Tiempos _tiempoFromMap(Map<String, Object?> m) => Tiempos(
        fecha: m['fecha'] as String,
        ntroquel: m['ntroquel'] as String,
        operarios: m['operarios'] as String?,
        ficha: m['ficha'] as String?,
        tiempo: (m['tiempo'] as num).toDouble(),
        actividad: _actividadFromStr(m['actividad'] as String),
      )..isarId = (m['id'] as int);

  Map<String, Object?> _materialToMap(Materiales m) => {
        'id': m.isarId,
        'codigo': m.codigo,
        'unidad': _unidadToStr(m.unidad),
        'descripcion': m.descripcion,
        'tipo': _tipoToStr(m.tipo),
        'conversion': m.conversion,
      };

  Materiales _materialFromMap(Map<String, Object?> m) => Materiales(
        codigo: (m['codigo'] as num).toInt(),
        unidad: _unidadFromStr(m['unidad'] as String),
        descripcion: m['descripcion'] as String,
        tipo: _tipoFromStr(m['tipo'] as String),
        conversion: (m['conversion'] as num).toDouble(),
      )..isarId = (m['id'] as int);

  Map<String, Object?> _consumoToMap(Consumo c) => {
        'id': c.isarid,
        'planta': c.planta,
        'nTroquel': c.nTroquel,
        'cliente': c.cliente,
        'tipo': c.tipo,
        'cantidad': c.cantidad,
      };

  Consumo _consumoFromMap(Map<String, Object?> m) => Consumo(
        nTroquel: m['nTroquel'] as String,
        planta: m['planta'] as String,
        cliente: m['cliente'] as String,
        tipo: m['tipo'] as String,
        cantidad: (m['cantidad'] as num).toInt(),
      )..isarid = (m['id'] as int);
}

/// Pequeño ayudante para “simular” IsarLinks en lectura
class _FakeIsarLinks<T> {
  final List<T> _items;
  _FakeIsarLinks(this._items);
  // Devuelve un objeto que luce como IsarLinks a efectos del constructor Consumo
  dynamic asIsarLinks() => _FakeIsarLinksWrapper<T>(_items);
}

class _FakeIsarLinksWrapper<T> {
  final List<T> _items;
  _FakeIsarLinksWrapper(this._items);
  void add(T item) => _items.add(item);
  void addAll(Iterable<T> items) => _items.addAll(items);
  Future<void> save() async {}
  Iterator<T> get iterator => _items.iterator;
  // Permite “for (final m in c.materiales)”
  // ignore: override_on_non_overriding_member
  T operator [](int i) => _items[i];
  // Para que el for-each funcione
  // ignore: iterable_contains_unrelated_type
  Iterable<T> get iterable => _items;
}
