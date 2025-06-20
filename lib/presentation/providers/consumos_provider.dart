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

  // Eliminar consumo por índice (memoria y base de datos)
  Future<void> removeConsumo(int index) async {
    if (index >= 0 && index < state.length) {
      final consumo = state[index];
      if (consumo.isarid != null) {
        await _isarDatasource.deleteConsumo(consumo.isarid!);
      }
      final updatedList = [...state]..removeAt(index);
      state = updatedList;
    }
  }

  // Actualizar consumo por índice (incluye guardar en la base de datos)
  Future<void> updateConsumo(int index, Consumo updatedConsumo) async {
    await _isarDatasource.updateConsumo(updatedConsumo); // <- SOLO 1 argumento
    if (index >= 0 && index < state.length) {
      final updatedList = [...state];
      updatedList[index] = updatedConsumo;
      state = updatedList;
    }
  }
}
