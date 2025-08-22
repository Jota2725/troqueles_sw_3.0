import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';

/// Notifier para manejar la lista de procesos (troqueles) en la BD,
/// permitiendo cargar todos, filtrar por estado y CRUD básico.
class ProcesoNotifier extends StateNotifier<List<Proceso>> {
  final IsarDatasource _isar;

  ProcesoNotifier(this._isar) : super(const []);

  /// Cargar procesos por estado (opcional).
  /// Si [estado] es null, trae TODOS los procesos.
  Future<void> loadProcesos({Estado? estado}) async {
    if (estado == null) {
      state = await _isar.getAllTroquelesInProcess(); // todos los procesos
    } else {
      state = await _isar.getTroquelesByEstado(estado);
    }
  }

  /// Azúcar sintáctico: cargar TODOS los procesos (cualquier estado).
  Future<void> loadProcesosAll() => loadProcesos();

  /// Crear un nuevo proceso.
  Future<void> addProceso(Proceso p) async {
    await _isar.addNewTroquelInProcess([p]);
    await loadProcesosAll();
  }

  /// Actualizar un proceso existente (requiere isarId en [p]).
  Future<void> updateProceso(Proceso p) async {
    await _isar.updatedTroquelInProcess(p);
    await loadProcesosAll();
  }

  /// Eliminar un proceso por su id de Isar.
  Future<void> deleteProceso(int id) async {
    await _isar.deleteTroquelInProcees(id);
    await loadProcesosAll();
  }

  /// Upsert conveniente si no sabes si existe (usa updated en tu flujo actual).
  Future<void> upsertProceso(Proceso p) async {
    await _isar.updatedTroquelInProcess(p);
    await loadProcesosAll();
  }

  /// Cambiar el estado de un proceso (por ejemplo, a completado).
  Future<void> setEstado(Proceso p, Estado nuevoEstado) async {
    final actualizado = Proceso(
      ntroquel: p.ntroquel,
      fechaIngreso: p.fechaIngreso,
      fechaEstimada: p.fechaEstimada,
      planta: p.planta,
      cliente: p.cliente,
      maquina: p.maquina,
      ingeniero: p.ingeniero,
      observaciones: p.observaciones,
      estado: nuevoEstado,
    )..isarId = p.isarId;

    await _isar.updatedTroquelInProcess(actualizado);
    await loadProcesosAll();
  }

  /// (Opcional) Buscar un proceso por N° de troquel.
  Future<Proceso?> findByNTroquel(String ntroquel) async {
    return await _isar.getTroquelInProcess(ntroquel);
  }
}

/// Provider con lista de procesos
final procesoProvider =
    StateNotifierProvider<ProcesoNotifier, List<Proceso>>((ref) {
  return ProcesoNotifier(IsarDatasource());
});

/// Provider para guardar el proceso/troquel seleccionado en la UI
final selectedProcesoProvider = StateProvider<Proceso?>((_) => null);
