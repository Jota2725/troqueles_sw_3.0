import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';

import '../../domain/entities/proceso.dart';

class TroquelNotifierInProceso extends StateNotifier<List<Proceso>> {
  final IsarDatasource _isarDatasource;

  TroquelNotifierInProceso(this._isarDatasource) : super([]);

  // Inicializar y cargar troqueles por maquina
  Future<void> loadTroquelesInProcces() async {
    state = await _isarDatasource.getAllTroquelesInProcess();
  }

  // Agregar un nuevo troquel
  Future<void> addTroquelInProceso(Proceso proceso) async {
    await _isarDatasource.addNewTroquelInProcess([proceso]);
    await loadTroquelesInProcces(); // Recargar los troqueles por máquina
  }


  Future<void> getAllTroquelesInProcess()async{

    await _isarDatasource.getAllTroquelesInProcess();
    await loadTroquelesInProcces();
  }

  Future<void> searchTroquelInProcess(String proceso,) async {
    final result =
        await _isarDatasource.getTroquelInProcess(proceso);
    if (result != null) {
      state = [result];
      // Actualiza el estado con el troquel encontrado
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
  Future<void> deleteTroquel(int id) async {
    await _isarDatasource.deleteTroquel(id);
    await loadTroquelesInProcces(); // Recargar los troqueles por máquina
  }

//   Future<void> deleteAllTroquelesbyMachine() async {
//     await _isarDatasource.deleteTroquelInProcees();
//     await loadTroqueles(maquina);
//   }
// Future<void> loadTroquelesLibres(String maquina) async {
//     final troquelesLibres = await _isarDatasource.getTroquelesLibres(maquina);
//     state = troquelesLibres; // Actualizar el estado con los troqueles libres específicos de la máquina
//   }
}

// Provider de TroquelNotifier
final troquelProviderInProceso =
    StateNotifierProvider<TroquelNotifierInProceso, List<Proceso>>((ref) {
  final isarDatasource = IsarDatasource();
  return TroquelNotifierInProceso(isarDatasource);
});
