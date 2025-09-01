import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';
import 'package:troqueles_sw/infrastructure/datasource/sqlite/sqlite_datasource.dart';

class ProcesoNotifier extends StateNotifier<List<Proceso>> {
  final SqliteDatasource _sqlite;

  ProcesoNotifier(this._sqlite) : super(const []);

  Future<void> loadProcesos({Estado? estado}) async {
    if (estado == null) {
      state = await _sqlite.getAllTroquelesInProcess();
    } else {
      state = await _sqlite.getTroquelesByEstado(estado);
    }
  }

  Future<void> loadEnProceso() => loadProcesos(estado: Estado.enProceso);

  Future<void> addProceso(Proceso p) async {
    await _sqlite.addNewTroquelInProcess([p]);
    await loadEnProceso();
  }

  Future<void> updateProceso(Proceso p) async {
    await _sqlite.updatedTroquelInProcess(p);
    await loadEnProceso();
  }

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

    await _sqlite.updatedTroquelInProcess(actualizado);
    await loadEnProceso();
  }

  Future<void> deleteProceso(int id) async {
    await _sqlite.deleteTroquelInProcees(id);
    await loadEnProceso();
  }

  Future<void> searchByNumero(String numero) async {
    final todos = await _sqlite.getAllTroquelesInProcess();
    state = todos.where((p) => p.ntroquel.contains(numero)).toList();
  }
}

final procesoProvider =
    StateNotifierProvider<ProcesoNotifier, List<Proceso>>((ref) {
  return ProcesoNotifier(SqliteDatasource.instance);
});

final selectedProcesoProvider = StateProvider<Proceso?>((_) => null);
