// lib/presentation/providers/consumos_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/consumo.dart';
import 'package:troqueles_sw/domain/entities/materiales.dart';
import 'package:troqueles_sw/infrastructure/datasource/sqlite/sqlite_datasource.dart';
import 'package:troqueles_sw/presentation/providers/consumos_provider_table.dart'
    show consumoTablaProvider;

class ConsumoNotifier extends StateNotifier<List<Consumo>> {
  final SqliteDatasource _sqlite;
  final Ref _ref;

  ConsumoNotifier(this._ref, this._sqlite) : super(const []);

  Future<void> loadConsumos() async {
    state = await _sqlite.getAllConsumos();
  }

  Future<void> addConsumoWithMaterials(
    Consumo consumo,
    List<Materiales> materialesSeleccionados,
  ) async {
    await _sqlite.addConsumoWithMaterials(consumo, materialesSeleccionados);
    await loadConsumos();
    // 🔹 refresca también la tabla plana
    await _ref.read(consumoTablaProvider.notifier).refresh();
  }

  Future<void> addConsumo(Consumo c) async {
    await _sqlite.addNewConsumo([c]);
    await loadConsumos();
    await _ref.read(consumoTablaProvider.notifier).refresh();
  }

  Future<void> updateConsumo(Consumo updated) async {
    await _sqlite.updateConsumo(updated);
    await loadConsumos();
    await _ref.read(consumoTablaProvider.notifier).refresh();
  }

  Future<void> deleteConsumo(int id) async {
    await _sqlite.deleteConsumo(id);
    await loadConsumos();
    await _ref.read(consumoTablaProvider.notifier).refresh();
  }
}

final consumoProvider =
    StateNotifierProvider<ConsumoNotifier, List<Consumo>>((ref) {
  return ConsumoNotifier(ref, SqliteDatasource());
});
