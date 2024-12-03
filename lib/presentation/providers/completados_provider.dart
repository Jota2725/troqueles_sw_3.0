import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';
import '../../domain/entities/proceso.dart';

class TroquelNotifierCompletados extends StateNotifier<List<Proceso>> {
  final IsarDatasource _isarDatasource;

  TroquelNotifierCompletados(this._isarDatasource) : super([]);

  // Cargar todos los procesos con estado 'completado'
  Future<void> loadTroquelesCompletados() async {
    state = await _isarDatasource.getTroquelesByEstado(Estado.completado);
  }

  // Agregar un proceso al estado 'completado'
  Future<void> addProcesoCompletado(Proceso proceso) async {
    if (proceso.estado != Estado.completado) {
      proceso = Proceso(
        ntroquel: proceso.ntroquel,
        fechaIngreso: proceso.fechaIngreso,
        fechaEstimada: proceso.fechaEstimada,
        planta: proceso.planta,
        cliente: proceso.cliente,
        maquina: proceso.maquina,
        ingeniero: proceso.ingeniero,
        observaciones: proceso.observaciones,
        estado: Estado.completado,
      ); // Actualiza el estado
    }
    await _isarDatasource.updatedTroquelInProcess(proceso);
    await loadTroquelesCompletados(); // Recargar los completados
  }

  // Buscar un proceso completado por algún criterio
  Future<void> searchTroquelCompletado(String idProceso) async {
    final result = await _isarDatasource.getTroquelInProcess(idProceso);
    if (result != null && result.estado == Estado.completado) {
      state = [result];
    } else {
      state = [];
    }
  }

  // Eliminar un proceso del estado 'completado'
  Future<void> deleteTroquelCompletado(int id) async {
    final proceso = state.firstWhere((proceso) => proceso.isarId == id);
    await _isarDatasource.deleteTroquelInProcees(proceso.isarId!);
    await loadTroquelesCompletados(); // Recargar los completados
  }
}

// Provider de TroquelNotifierCompletados
final troquelProviderCompletados =
    StateNotifierProvider<TroquelNotifierCompletados, List<Proceso>>((ref) {
  final isarDatasource = IsarDatasource();
  final notifier = TroquelNotifierCompletados(isarDatasource);
  notifier.loadTroquelesCompletados(); // Carga inicial
  return notifier;
});
