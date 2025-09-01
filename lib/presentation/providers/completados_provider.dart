import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/infrastructure/datasource/sqlite/sqlite_datasource.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';

class TroquelNotifierCompletados extends StateNotifier<List<Proceso>> {
  final SqliteDatasource _db;
  TroquelNotifierCompletados(this._db) : super(const []);

  Future<void> loadTroquelesCompletados() async {
    state = await _db.getTroquelesByEstado(Estado.completado);
  }

  Future<void> addProcesoCompletado(Proceso proceso) async {
    final p = Proceso(
      ntroquel: proceso.ntroquel,
      fechaIngreso: proceso.fechaIngreso,
      fechaEstimada: proceso.fechaEstimada,
      planta: proceso.planta,
      cliente: proceso.cliente,
      maquina: proceso.maquina,
      ingeniero: proceso.ingeniero,
      observaciones: proceso.observaciones,
      estado: Estado.completado,
    )..isarId = proceso.isarId;
    await _db.updatedTroquelInProcess(p);
    await loadTroquelesCompletados();
  }

  Future<void> deleteTroquelCompletado(int id) async {
    await _db.deleteTroquelInProcees(id);
    await loadTroquelesCompletados();
  }
}

final troquelProviderCompletados =
    StateNotifierProvider<TroquelNotifierCompletados, List<Proceso>>((ref) {
  final notifier = TroquelNotifierCompletados(SqliteDatasource());
  notifier.loadTroquelesCompletados();
  return notifier;
});
