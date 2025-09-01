// lib/infrastructure/sqlite/sqlite_datasource.dart
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../domain/entities/troquel.dart';
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
Actividad _actividadFromStr(String s) => Actividad.values
    .firstWhere((e) => e.name == s, orElse: () => Actividad.Dibujo);

String _unidadToStr(Unidad u) => u.name;
Unidad _unidadFromStr(String s) =>
    Unidad.values.firstWhere((e) => e.name == s, orElse: () => Unidad.und);

String _tipoToStr(Tipo t) => t.name;
Tipo _tipoFromStr(String s) =>
    Tipo.values.firstWhere((e) => e.name == s, orElse: () => Tipo.herramientas);

class SqliteDatasource {
  // --------------------------- Singleton ---------------------------
  SqliteDatasource._internal();
  static final SqliteDatasource instance = SqliteDatasource._internal();
  factory SqliteDatasource() => instance;

  // =========================== PROCESOS ===========================
  Future<List<Proceso>> getAllTroquelesInProcess() async {
    final db = await SqliteDb.getDb();
    final rows = await db.query('procesos', orderBy: 'id DESC');
    return rows.map(_procesoFromMap).toList();
  }

  Future<List<Proceso>> getTroquelesByEstado(Estado estado) async {
    final db = await SqliteDb.getDb();
    final rows = await db.query(
      'procesos',
      where: 'estado = ?',
      whereArgs: [_estadoToStr(estado)],
      orderBy: 'id DESC',
    );
    return rows.map(_procesoFromMap).toList();
  }

  Future<Proceso?> getTroquelInProcess(String ntroquel) async {
    final db = await SqliteDb.getDb();
    final rows = await db.query(
      'procesos',
      where: 'ntroquel = ?',
      whereArgs: [ntroquel],
      limit: 1,
    );
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

  // =========================== TIEMPOS ===========================
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

  // =========================== MATERIALES ===========================
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

  // =========================== CONSUMOS ===========================
  /// Lee los consumos. Nota: devolvemos el `Consumo` con **materiales vacíos**;
  /// si necesitas mostrar materiales por consumo en UI, cárgalos aparte.
  Future<List<Consumo>> getAllConsumos() async {
    final db = await SqliteDb.getDb();
    final rows = await db.query('consumos', orderBy: 'id DESC');

    final result = <Consumo>[];
    for (final r in rows) {
      final base = _consumoFromMap(r);
      // NO llenar base.materiales con wrappers ni IsarLinks falsos.
      result.add(base);
    }
    return result;
  }

  /// Inserta múltiples consumos (con sus materiales) usando el método single.
  Future<void> addNewConsumo(List<Consumo> consumos) async {
    for (final c in consumos) {
      await addConsumoSingle(c);
    }
  }

  /// Inserta un solo consumo **usando los materiales que trae el objeto**.
  /// Vincula por `codigo` del material a la tabla intermedia.
  Future<int> addConsumoSingle(Consumo c) async {
    final db = await SqliteDb.getDb();
    return await db.transaction<int>((txn) async {
      final consumoId = await txn.insert('consumos', _consumoToMap(c));

      for (final m in c.materiales) {
        final mats = await txn.query(
          'materiales',
          where: 'codigo = ?',
          whereArgs: [m.codigo],
          limit: 1,
        );
        if (mats.isNotEmpty) {
          final materialId = mats.first['id'] as int;
          await txn.insert(
            'consumo_material',
            {'consumo_id': consumoId, 'material_id': materialId},
            conflictAlgorithm: ConflictAlgorithm.ignore,
          );
        }
      }
      return consumoId;
    });
  }

  /// Inserta un consumo y la lista explícita de materiales seleccionados.
  Future<void> addConsumoWithMaterials(
      Consumo c, List<Materiales> matsSel) async {
    final db = await SqliteDb.getDb();
    await db.transaction((txn) async {
      final consumoId = await txn.insert('consumos', _consumoToMap(c));

      for (final m in matsSel) {
        final mats = await txn.query(
          'materiales',
          where: 'codigo = ?',
          whereArgs: [m.codigo],
          limit: 1,
        );
        if (mats.isNotEmpty) {
          final materialId = mats.first['id'] as int;
          await txn.insert(
            'consumo_material',
            {'consumo_id': consumoId, 'material_id': materialId},
            conflictAlgorithm: ConflictAlgorithm.ignore,
          );
        }
      }
    });
  }

  Future<void> updateConsumo(Consumo c) async {
    final db = await SqliteDb.getDb();
    await db.transaction((txn) async {
      await txn.update('consumos', _consumoToMap(c),
          where: 'id = ?', whereArgs: [c.isarid]);
      await txn.delete('consumo_material',
          where: 'consumo_id = ?', whereArgs: [c.isarid]);

      for (final m in c.materiales) {
        final mats = await txn.query('materiales',
            where: 'codigo = ?', whereArgs: [m.codigo], limit: 1);
        if (mats.isNotEmpty) {
          final materialId = mats.first['id'] as int;
          await txn.insert(
            'consumo_material',
            {'consumo_id': c.isarid, 'material_id': materialId},
            conflictAlgorithm: ConflictAlgorithm.ignore,
          );
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

  // =========================== TROQUELES (catálogo) ===========================
  Future<List<Troquel>> getAllTroquelesPorMaquina(String maquina) async {
    final db = await SqliteDb.getDb();
    final rows = await db.query(
      'troqueles',
      where: 'maquina = ?',
      whereArgs: [maquina],
      orderBy: 'id DESC',
    );
    return rows.map(_troquelFromMap).toList();
  }

  Future<void> saveTroqueles(List<Troquel> troqueles) async {
    final db = await SqliteDb.getDb();
    final batch = db.batch();
    for (final t in troqueles) {
      batch.insert('troqueles', _troquelToMap(t));
    }
    await batch.commit(noResult: true);
  }

  Future<Troquel?> getTroquelByGicoAndMaquina(int gico, String maquina) async {
    final db = await SqliteDb.getDb();
    final rows = await db.query(
      'troqueles',
      where: 'gico = ? AND maquina = ?',
      whereArgs: [gico, maquina],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return _troquelFromMap(rows.first);
  }

  Future<void> updateTroquel(Troquel troquel) async {
    final db = await SqliteDb.getDb();
    await db.update(
      'troqueles',
      _troquelToMap(troquel),
      where: 'id = ?',
      whereArgs: [troquel.isarId],
    );
  }

  Future<void> deleteTroquel(int id) async {
    final db = await SqliteDb.getDb();
    await db.delete('troqueles', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllTroquelesbyMachine(String maquina) async {
    final db = await SqliteDb.getDb();
    await db.delete('troqueles', where: 'maquina = ?', whereArgs: [maquina]);
  }

  Future<List<Troquel>> getTroquelesLibres(String maquina) async {
    final db = await SqliteDb.getDb();
    final rows = await db.query(
      'troqueles',
      where: 'maquina = ? AND (ubicacion IS NULL OR ubicacion = "")',
      whereArgs: [maquina],
      orderBy: 'id DESC',
    );
    return rows.map(_troquelFromMap).toList();
  }

  // =========================== OPERARIOS ===========================
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
      batch.insert('operarios', {'ficha': o.ficha, 'nombre': o.nombre});
    }
    await batch.commit(noResult: true);
  }

  // =========================== RESUMEN GENERAL ===========================
  Future<List<GeneralInfo>> getResumenGeneral() async {
    final db = await SqliteDb.getDb();

    final procesos = await db.query('procesos', orderBy: 'id ASC');
    final meta = <String, Map<String, String>>{};
    for (final p in procesos) {
      meta[p['ntroquel'] as String] = {
        'cliente': p['cliente'] as String? ?? '',
        'planta': p['planta'] as String? ?? '',
      };
    }

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
        mapa[n] = mapa[n]!.copyWith(totalTiempo: mapa[n]!.totalTiempo + total);
      }
    }

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

  /// ====== CONSOLIDADO PARA LA TABLA DE CONSUMOS ======
  /// Devuelve filas ya "aplanadas" con los materiales concatenados.
  Future<List<ConsumoTablaRow>> getConsumosTablaRows() async {
    final db = await SqliteDb.getDb();

    final rows = await db.rawQuery('''
    SELECT
      c.id                 AS id,
      c.planta             AS planta,
      c.cliente            AS cliente,
      c.nTroquel           AS nTroquel,
      c.cantidad           AS cantidad,
      /* OJO: los GROUP_CONCAT usan coma por defecto */
      GROUP_CONCAT(m.codigo)       AS codigos,
      GROUP_CONCAT(m.conversion)   AS conversiones,
      GROUP_CONCAT(m.unidad)       AS unidades,
      GROUP_CONCAT(m.descripcion)  AS descripciones,
      GROUP_CONCAT(m.tipo)         AS tipos
    FROM consumos c
    LEFT JOIN consumo_material cm ON cm.consumo_id = c.id
    LEFT JOIN materiales m        ON m.id = cm.material_id
    GROUP BY c.id
    ORDER BY c.id DESC
  ''');

    return rows
        .map((r) => ConsumoTablaRow(
              id: (r['id'] as num).toInt(),
              planta: (r['planta'] as String?) ?? '',
              cliente: (r['cliente'] as String?) ?? '',
              nTroquel: (r['nTroquel'] as String?) ?? '',
              cantidad: (r['cantidad'] as num?)?.toInt() ?? 0,
              codigos: (r['codigos'] as String?) ?? '',
              conversiones: (r['conversiones'] as String?) ?? '',
              unidades: (r['unidades'] as String?) ?? '',
              descripciones: (r['descripciones'] as String?) ?? '',
              tipos: (r['tipos'] as String?) ?? '',
            ))
        .toList();
  }

  // -------------------- Alias usados por tus providers --------------------
  Future<List<Proceso>> getAllProcesos() => getAllTroquelesInProcess();
  Future<List<Proceso>> getProcesosByEstado(Estado e) =>
      getTroquelesByEstado(e);
  Future<void> addProceso(Proceso p) => addNewTroquelInProcess([p]);
  Future<void> updateProceso(Proceso p) => updatedTroquelInProcess(p);
  Future<void> deleteProceso(int id) => deleteTroquelInProcees(id);

  Future<void> updateEstado(Proceso p, Estado nuevo) async {
    final actualizado = Proceso(
      ntroquel: p.ntroquel,
      fechaIngreso: p.fechaIngreso,
      fechaEstimada: p.fechaEstimada,
      planta: p.planta,
      cliente: p.cliente,
      maquina: p.maquina,
      ingeniero: p.ingeniero,
      observaciones: p.observaciones,
      estado: nuevo,
    )..isarId = p.isarId;
    await updatedTroquelInProcess(actualizado);
  }

  // Tiempos
  Future<void> addTiempo(Tiempos t) => addNewTiempo([t]);
  Future<void> updateTiempo(Tiempos t) => uptadeTime(t);
  Future<void> deleteTiempo(int id) => deleteTiempos(id);

  // Materiales
  Future<List<Materiales>> getAllMateriales() => gettAllMateriles();
  Future<void> addMateriales(List<Materiales> ms) => addNewMaterial(ms);
}

// =========================== MAPeos ===========================
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

Map<String, Object?> _troquelToMap(Troquel t) => {
      'id': t.isarId,
      'nota': t.nota,
      'ubicacion': t.ubicacion,
      'gico': t.gico,
      'referencia': t.referencia,
      'cliente': t.cliente,
      'no_cad': t.no_cad,
      'maquina': t.maquina,
      'clave': t.clave,
      'alto': t.alto,
      'largo': t.largo,
      'ancho': t.ancho,
      'cabida': t.cabida,
      'estilo': t.estilo,
      'descripcion': t.descripcion,
      'sector': t.sector,
    };

Troquel _troquelFromMap(Map<String, Object?> m) => Troquel(
      nota: m['nota'] as String?,
      ubicacion: m['ubicacion'] as String?,
      gico: (m['gico'] as num).toInt(),
      referencia: m['referencia'] as String,
      cliente: m['cliente'] as String,
      no_cad: m['no_cad'] as String?,
      maquina: m['maquina'] as String,
      clave: m['clave'] as String?,
      alto: m['alto'] as String?,
      largo: m['largo'] as String?,
      ancho: m['ancho'] as String?,
      cabida: m['cabida'] as String?,
      estilo: m['estilo'] as String?,
      descripcion: m['descripcion'] as String?,
      sector: m['sector'] as String?,
    )..isarId = (m['id'] as int);

Consumo _consumoFromMap(Map<String, Object?> m) => Consumo(
      nTroquel: m['nTroquel'] as String,
      planta: m['planta'] as String,
      cliente: m['cliente'] as String,
      tipo: m['tipo'] as String,
      cantidad: (m['cantidad'] as num).toInt(),
    )..isarid = (m['id'] as int);

class ConsumoTablaRow {
  final int id;
  final String planta;
  final String cliente;
  final String nTroquel;
  final int cantidad;
  final String codigos;
  final String conversiones;
  final String unidades;
  final String descripciones;
  final String tipos;

  ConsumoTablaRow({
    required this.id,
    required this.planta,
    required this.cliente,
    required this.nTroquel,
    required this.cantidad,
    required this.codigos,
    required this.conversiones,
    required this.unidades,
    required this.descripciones,
    required this.tipos,
  });
}
