import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/tiempos.dart';
import 'package:troqueles_sw/infrastructure/datasource/sqlite/sqlite_datasource.dart';

class TiemposNotifier extends StateNotifier<List<Tiempos>> {
  final SqliteDatasource _sqlite;

  TiemposNotifier(this._sqlite) : super(const []);

  Future<void> loadTiempos() async {
    state = await _sqlite.getAllTiempos();
  }

  Future<void> addTiempo(Tiempos t) async {
    await _sqlite.addNewTiempo([t]);
    state = await _sqlite.getAllTiempos();
  }

  Future<void> updateTiempo(Tiempos t) async {
    await _sqlite.uptadeTime(t);
    state = await _sqlite.getAllTiempos();
  }

  Future<void> deleteTiempos(int id) async {
    await _sqlite.deleteTiempos(id);
    state = await _sqlite.getAllTiempos();
  }
}

final timeProvider =
    StateNotifierProvider<TiemposNotifier, List<Tiempos>>((ref) {
  return TiemposNotifier(SqliteDatasource.instance);
});
