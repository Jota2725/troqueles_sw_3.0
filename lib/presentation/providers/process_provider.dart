import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';
import '../../domain/entities/proceso.dart';

final selectedProcesoProvider = StateProvider<Proceso?>((ref) => null);

class TroquelNotifierInProceso extends StateNotifier<List<Proceso>> {
  final IsarDatasource _isarDatasource;

  TroquelNotifierInProceso(this._isarDatasource) : super([]);

  // Inicializar y cargar troqueles por máquina
  Future<void> loadTroquelesInProcces() async {
    final todosLosProcesos = await _isarDatasource.getAllTroquelesInProcess();
    state = todosLosProcesos.where((proceso) => proceso.estado != Estado.completado).toList();
  }

  // Agregar un nuevo troquel
  Future<void> addTroquelInProceso(Proceso proceso) async {
    await _isarDatasource.addNewTroquelInProcess([proceso]);
    await loadTroquelesInProcces(); // Recargar los troqueles por máquina
  }

  Future<void> getAllTroquelesInProcess() async {
    await _isarDatasource.getAllTroquelesInProcess();
    await loadTroquelesInProcces();
  }

  Future<void> searchTroquelInProcess(String proceso) async {
    final result = await _isarDatasource.getTroquelInProcess(proceso);
    if (result != null) {
      state = [result]; // Actualiza el estado con el troquel encontrado
    } else {
      state = []; // Limpia el estado si no se encuentra el troquel
    }
  }

  // Actualizar un troquel existente
  Future<void> updateTroquel(Proceso proceso) async {
    await _isarDatasource.updatedTroquelInProcess(proceso);
    await loadTroquelesInProcces(); // Recargar los troqueles por máquina
  }

  // Eliminar un troquel por ID
  Future<void> deleteTroquelInProcees(int id) async {
    await _isarDatasource.deleteTroquelInProcees(id);
    await loadTroquelesInProcces(); // Recargar los troqueles por máquina
  }

  // Método para actualizar el orden de los procesos
  void updateProcesosOrder(List<Proceso> nuevosProcesos) {
    state = nuevosProcesos; // Actualiza el estado con la nueva lista ordenada
  }
}

// Provider de TroquelNotifier
final troquelProviderInProceso =
    StateNotifierProvider<TroquelNotifierInProceso, List<Proceso>>((ref) {
  final isarDatasource = IsarDatasource();
  return TroquelNotifierInProceso(isarDatasource);
});