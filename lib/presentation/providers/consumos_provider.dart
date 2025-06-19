import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/consumo.dart';

import '../../infrastructure/datasource/isar_datasource.dart';

final consumoProvider =
    StateNotifierProvider<ConsumoNotifier, List<Consumo>>((ref) {
  final isarDatasource = IsarDatasource();
  return ConsumoNotifier(isarDatasource);
});

class ConsumoNotifier extends StateNotifier<List<Consumo>> {
  final IsarDatasource _isarDatasource;

  ConsumoNotifier(this._isarDatasource) : super([]);

  // Cargar todos los consumos desde la base de datos
  Future<void> loadConsumos() async {
    state = await _isarDatasource.getAllConsumos();
  }

  // Agregar un nuevo consumo
  Future<void> addConsumo(Consumo consumo) async {
    await _isarDatasource.addNewConsumo([consumo]);
    state = [...state, consumo];
  }

  // Eliminar consumo por índice (solo en memoria)
  void removeConsumo(int index) {
    if (index >= 0 && index < state.length) {
      final updatedList = [...state]..removeAt(index);
      state = updatedList;
    }
  }

  // Actualizar consumo por índice (solo en memoria)
  void updateConsumo(int index, Consumo updatedConsumo) {
    if (index >= 0 && index < state.length) {
      final updatedList = [...state];
      updatedList[index] = updatedConsumo;
      state = updatedList;
    }
  }
}
