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

  // Cargar todos los consumos
  Future<void> loadConsumos() async {
    state = await _isarDatasource.getAllConsumos();
  }

  // Agregar un nuevo consumo
  Future<void> addConsumo(Consumo consumo) async {
    await _isarDatasource.addNewConsumo([consumo]);
    // Actualizar la lista de consumos después de agregar
    state = [...state, consumo];
  }
}
