import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/tiempos.dart';
import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';
import 'package:troqueles_sw/presentation/providers/sync_provider.dart';
import 'package:troqueles_sw/infrastructure/sync/sync_service.dart';

class TiemposNotifier extends StateNotifier<List<Tiempos>> {
  final IsarDatasource _isar;
  final SyncService _sync;

  TiemposNotifier(this._isar, this._sync) : super(const []);

  Future<void> loadTiempos() async {
    state = await _isar.getAllTiempos();
  }

  Future<void> addTiempo(Tiempos t) async {
    await _isar.addNewTiempo([t]);
    state = [...state, t];
    try {
      await _sync.pushTiempo(t);
    } catch (_) {}
  }

  Future<void> updateTiempo(Tiempos t) async {
    await _isar.uptadeTime(t);
    await loadTiempos();
    try {
      await _sync.pushTiempo(t);
    } catch (_) {}
  }

  Future<void> deleteTiempos(int id) async {
    await _isar.deleteTiempos(id);
    await loadTiempos();
    // Nota: si luego manejas serverId remoto, aquí haces delete remoto.
  }
}

final timeProvider =
    StateNotifierProvider<TiemposNotifier, List<Tiempos>>((ref) {
  final isar = IsarDatasource();
  final sync = ref.read(syncServiceProvider); // <-- de sync_provider.dart
  return TiemposNotifier(isar, sync);
});
