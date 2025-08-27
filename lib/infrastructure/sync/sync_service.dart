// lib/infrastructure/sync/sync_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';
import 'package:troqueles_sw/domain/entities/tiempos.dart';
import 'package:troqueles_sw/domain/entities/consumo.dart';
import 'package:troqueles_sw/domain/entities/materiales.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';
import 'package:troqueles_sw/config/server_config.dart';
import 'package:isar/isar.dart';

class SyncService {
  final IsarDatasource isar;

  SyncService(this.isar);

  Future<String> _base() => ServerConfig.getBaseUrl();

  // ------------------ PULL: traer del servidor y reemplazar Isar ------------------

  Future<void> pullProcesos() async {
    final url = Uri.parse('${await _base()}/api/procesos');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body) as List;

      final procesos = data.map((p) {
        return Proceso(
          ntroquel: p['ntroquel'] as String,
          fechaIngreso: DateTime.parse(p['fechaIngreso'] as String),
          fechaEstimada: p['fechaEstimada'] != null
              ? DateTime.parse(p['fechaEstimada'] as String)
              : null,
          planta: p['planta'] as String? ?? '',
          cliente: p['cliente'] as String? ?? '',
          maquina: p['maquina'] as String? ?? '',
          ingeniero: p['ingeniero'] as String? ?? '',
          observaciones: p['observaciones'] as String? ?? '',
          estado: Estado.values.firstWhere(
            (e) =>
                e.name.toLowerCase() == (p['estado'] as String).toLowerCase(),
            orElse: () => Estado.pendiente,
          ),
        );
      }).toList();

      final isarDb = await isar.db;
      await isarDb.writeTxn(() async {
        await isarDb.procesos.clear();
        await isarDb.procesos.putAll(procesos);
      });
    }
  }

  Future<void> pullTiempos() async {
    final url = Uri.parse('${await _base()}/api/tiempos');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body) as List;

      final tiempos = data.map((t) {
        return Tiempos(
          fecha: t['fecha'] as String, // en tu entidad es String
          ntroquel: t['ntroquel'] as String,
          operarios: t['operarios'] as String?,
          ficha: t['ficha'] as String?,
          tiempo: (t['tiempo'] as num).toDouble(),
          actividad: Actividad.values.firstWhere(
            (e) =>
                e.name.toLowerCase() ==
                (t['actividad'] as String).toLowerCase(),
            orElse: () => Actividad.Dibujo,
          ),
        );
      }).toList();

      final isarDb = await isar.db;
      await isarDb.writeTxn(() async {
        await isarDb.tiempos.clear();
        await isarDb.tiempos.putAll(tiempos);
      });
    }
  }

  Future<void> pullConsumos() async {
    final url = Uri.parse('${await _base()}/api/consumos');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body) as List;

      // Insertamos consumos y linkeamos materiales (por código)
      final isarDb = await isar.db;
      await isarDb.writeTxn(() async {
        await isarDb.consumos.clear();
      });

      for (final c in data) {
        final consumo = Consumo(
          nTroquel: c['nTroquel'] as String,
          planta: c['planta'] as String? ?? '',
          cliente: c['cliente'] as String? ?? '',
          tipo: c['tipo'] as String? ?? '',
          cantidad: (c['cantidad'] as num).toInt(),
        );

        final isarDb = await isar.db;
        await isarDb.writeTxn(() async {
          await isarDb.consumos.put(consumo);

          // materiales: lista de {codigo: int}
          if (c['materiales'] is List) {
            final List mats = c['materiales'] as List;
            for (final m in mats) {
              final codigo = (m['codigo'] as num?)?.toInt();
              if (codigo == null) continue;
              final mat = await isarDb.materiales
                  .filter()
                  .codigoEqualTo(codigo)
                  .findFirst();
              if (mat != null) {
                consumo.materiales.add(mat);
              }
            }
            await consumo.materiales.save();
          }
        });
      }
    }
  }

  Future<void> pullAll() async {
    await pullProcesos();
    await pullTiempos();
    await pullConsumos();
  }

  // ------------------ PUSH: enviar cambios locales al servidor ------------------

  Future<void> pushTiempo(Tiempos t, {int? serverId}) async {
    final body = {
      'fecha': t.fecha,
      'ntroquel': t.ntroquel,
      'operarios': t.operarios,
      'ficha': t.ficha,
      'tiempo': t.tiempo,
      'actividad': t.actividad.name,
    };

    final url = serverId == null
        ? Uri.parse('${await _base()}/api/tiempos')
        : Uri.parse('${await _base()}/api/tiempos/$serverId');

    await (serverId == null
        ? http.post(url,
            body: jsonEncode(body),
            headers: {'Content-Type': 'application/json'})
        : http.put(url,
            body: jsonEncode(body),
            headers: {'Content-Type': 'application/json'}));
  }

  Future<void> pushConsumo(Consumo c, {int? serverId}) async {
    // Enviamos códigos de materiales (best-effort)
    final mats = <Map<String, dynamic>>[];
    for (final m in c.materiales) {
      mats.add({'codigo': m.codigo});
    }

    final body = {
      'planta': c.planta,
      'nTroquel': c.nTroquel,
      'cliente': c.cliente,
      'tipo': c.tipo,
      'cantidad': c.cantidad,
      'materiales': mats,
    };

    final url = serverId == null
        ? Uri.parse('${await _base()}/api/consumos')
        : Uri.parse('${await _base()}/api/consumos/$serverId');

    await (serverId == null
        ? http.post(url,
            body: jsonEncode(body),
            headers: {'Content-Type': 'application/json'})
        : http.put(url,
            body: jsonEncode(body),
            headers: {'Content-Type': 'application/json'}));
  }

  Future<void> deleteTiempoRemote(int serverId) async {
    final url = Uri.parse('${await _base()}/api/tiempos/$serverId');
    await http.delete(url);
  }

  Future<void> deleteConsumoRemote(int serverId) async {
    final url = Uri.parse('${await _base()}/api/consumos/$serverId');
    await http.delete(url);
  }
}
