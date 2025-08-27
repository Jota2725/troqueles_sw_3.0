import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/consumo.dart';
import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';
import 'package:troqueles_sw/presentation/providers/sync_provider.dart';
import 'package:troqueles_sw/infrastructure/sync/sync_service.dart';

class ConsumoNotifier extends StateNotifier<List<Consumo>> {
  final IsarDatasource _isar;
  final SyncService _sync;

  ConsumoNotifier(this._isar, this._sync) : super(const []);

  Future<void> loadConsumos() async {
    state = await _isar.getAllConsumos();
  }

  Future<void> addConsumo(Consumo c) async {
    await _isar.addNewConsumo([c]);
    state = [...state, c];
    // push al servidor
    try {
      await _sync.pushConsumo(c);
    } catch (_) {
      // opcional: mostrar snackbar en la UI
    }
  }

  Future<void> updateConsumo(int index, Consumo updated) async {
    await _isar.updateConsumo(updated);
    await loadConsumos();
    try {
      await _sync.pushConsumo(updated);
    } catch (_) {}
  }

  Future<void> removeConsumo(int index) async {
    final c = state[index];
    final id = c.isarid;
    if (id != null) {
      await _isar.deleteConsumo(id);
    }
    await loadConsumos();
    // Nota: si luego manejas serverId, aquí llamas delete remoto.
  }
}

final consumoProvider =
    StateNotifierProvider<ConsumoNotifier, List<Consumo>>((ref) {
  final isar = IsarDatasource();
  final sync = ref.read(syncServiceProvider); // <-- de sync_provider.dart
  return ConsumoNotifier(isar, sync);
});
