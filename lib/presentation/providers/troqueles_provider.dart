import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';
import 'package:troqueles_sw/infrastructure/datasource/sqlite/sqlite_datasource.dart';
import '../../domain/entities/proceso.dart';

class TroquelNotifier extends StateNotifier<List<Troquel>> {
  final SqliteDatasource _sqlite;

  TroquelNotifier(this._sqlite) : super([]);

  // Inicializar y cargar troqueles por maquina
  Future<void> loadTroqueles(String maquina) async {
    state = await _sqlite.getAllTroquelesPorMaquina(maquina);
  }

  // Agregar un nuevo troquel
  Future<void> addTroquel(Troquel troquel) async {
    await _sqlite.saveTroqueles([troquel]);
    await loadTroqueles(troquel.maquina);
  }

  Future<void> addTroquelInprocess(Proceso proceso) async {
    // Si necesitas crear también un Proceso en la tabla 'procesos'
    await _sqlite.addNewTroquelInProcess([proceso]);
    // Este setState no es estrictamente necesario para la lista de troqueles de catálogo
    // pero lo dejamos consistente
    state = await _sqlite.getAllTroquelesPorMaquina(proceso.maquina);
  }

  Future<void> searchTroquel(int gico, String maquina) async {
    final result = await _sqlite.getTroquelByGicoAndMaquina(gico, maquina);
    state = (result != null) ? [result] : [];
  }

  // Actualizar un troquel existente
  Future<void> updateTroquel(Troquel troquel) async {
    await _sqlite.updateTroquel(troquel);
    await loadTroqueles(troquel.maquina);
  }

  // Eliminar un troquel por ID
  Future<void> deleteTroquel(int id, String maquina) async {
    await _sqlite.deleteTroquel(id);
    await loadTroqueles(maquina);
  }

  Future<void> deleteAllTroquelesbyMachine(String maquina) async {
    await _sqlite.deleteAllTroquelesbyMachine(maquina);
    await loadTroqueles(maquina);
  }

  Future<void> loadTroquelesLibres(String maquina) async {
    final troquelesLibres = await _sqlite.getTroquelesLibres(maquina);
    state = troquelesLibres;
  }
}

// Provider de TroquelNotifier
final troquelProvider =
    StateNotifierProvider<TroquelNotifier, List<Troquel>>((ref) {
  return TroquelNotifier(SqliteDatasource.instance);
});
