import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';
import 'package:troqueles_sw/infrastructure/sync/sync_service.dart';

import 'package:troqueles_sw/presentation/providers/process_provider.dart';
import 'package:troqueles_sw/presentation/providers/timepos_provider.dart';
import 'package:troqueles_sw/presentation/providers/consumos_provider.dart';
import 'package:troqueles_sw/presentation/providers/materials_provider.dart';

/// Servicio de sincronización (usa tu IsarDatasource interno)
final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(IsarDatasource());
});

/// Controlador de sincronización: expone un bool "sincronizando"
class SyncController extends StateNotifier<bool> {
  final Ref ref;
  SyncController(this.ref) : super(false);

  /// Hace PULL (traer del server) y refresca providers de la UI
  Future<void> syncNow() async {
    if (state) return; // evita doble click
    state = true;
    try {
      final sync = ref.read(syncServiceProvider);
      await sync.pullAll();

      // refrescar providers para que la UI se entere
      await ref.read(procesoProvider.notifier).loadProcesos(); // todos
      await ref.read(timeProvider.notifier).loadTiempos(); // tiempos
      await ref.read(consumoProvider.notifier).loadConsumos(); // consumos
      await ref
          .read(materialProvider.notifier)
          .loadMateriales(); // materiales (opcional)
    } finally {
      state = false;
    }
  }
}

/// Provider de controller (lee el booleano "sincronizando")
final syncControllerProvider =
    StateNotifierProvider<SyncController, bool>((ref) => SyncController(ref));
