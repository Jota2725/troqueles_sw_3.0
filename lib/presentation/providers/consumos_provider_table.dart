// lib/presentation/providers/consumos_provider_table.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/infrastructure/datasource/sqlite/sqlite_datasource.dart';
import 'package:troqueles_sw/infrastructure/datasource/sqlite/sqlite_db.dart';

class ConsumoTablaNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  final SqliteDatasource _sqlite;
  ConsumoTablaNotifier(this._sqlite) : super(const []);

  Future<void> refresh() async {
    final db = await SqliteDb.getDb();
    final rows = await db.rawQuery('''
      SELECT 
        COALESCE(p.planta, '')        AS planta,
        COALESCE(p.cliente, '')       AS cliente,
        c.nTroquel                    AS ntroquel,
        m.codigo                      AS codigo,
        c.cantidad                    AS cantidad,
        m.conversion                  AS conversion,
        m.unidad                      AS unidad,
        m.descripcion                 AS descripcion,
        m.tipo                        AS tipo
      FROM consumos c
      JOIN consumo_material cm ON cm.consumo_id = c.id
      JOIN materiales m       ON m.id = cm.material_id
      LEFT JOIN procesos p    ON p.ntroquel = c.nTroquel
      ORDER BY c.id DESC;
    ''');
    state = rows;
  }
}

final consumoTablaProvider =
    StateNotifierProvider<ConsumoTablaNotifier, List<Map<String, dynamic>>>(
  (ref) => ConsumoTablaNotifier(SqliteDatasource()),
);
