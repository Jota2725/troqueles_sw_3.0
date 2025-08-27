import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';

/// Notifier para manejar TODOS los procesos (sin limitarse a un estado).
class ProcesoNotifier extends StateNotifier<List<Proceso>> {
  final IsarDatasource _isar;

  ProcesoNotifier(this._isar) : super(const []);

  /// Cargar procesos por estado (opcional). Si [estado] es null => TODOS.
  Future<void> loadProcesos({Estado? estado}) async {
    if (estado == null) {
      state = await _isar.getAllTroquelesInProcess();
    } else {
      state = await _isar.getTroquelesByEstado(estado);
    }
  }

  /// Azúcar: cargar únicamente los "enProceso".
  Future<void> loadEnProceso() => loadProcesos(estado: Estado.enProceso);

  /// Crear (agregar) un proceso nuevo.
  Future<void> addProceso(Proceso p) async {
    await _isar.addNewTroquelInProcess([p]);
    await loadEnProceso(); // mantener la vista filtrada
  }

  /// Actualizar un proceso completo (editar campos).
  Future<void> updateProceso(Proceso p) async {
    await _isar.updatedTroquelInProcess(p);
    await loadEnProceso();
  }

  /// Actualizar SOLO el estado y refrescar la lista "enProceso".
  Future<void> updateEstado(Proceso p, Estado nuevo) async {
    final actualizado = Proceso(
      ntroquel: p.ntroquel,
      fechaIngreso: p.fechaIngreso,
      fechaEstimada: p.fechaEstimada,
      planta: p.planta,
      cliente: p.cliente,
      maquina: p.maquina,
      ingeniero: p.ingeniero,
      observaciones: p.observaciones,
      estado: nuevo,
    )..isarId = p.isarId;

    await _isar.updatedTroquelInProcess(actualizado);
    await loadEnProceso();
  }

  /// Eliminar un proceso por id.
  Future<void> deleteProceso(int id) async {
    await _isar.deleteTroquelInProcees(id);
    await loadEnProceso();
  }

  /// Búsqueda por N° troquel (útil para el buscador).
  Future<void> searchByNumero(String numero) async {
    final todos = await _isar.getAllTroquelesInProcess();
    state = todos.where((p) => p.ntroquel.contains(numero)).toList();
  }
}

/// Provider con lista de procesos
final procesoProvider =
    StateNotifierProvider<ProcesoNotifier, List<Proceso>>((ref) {
  return ProcesoNotifier(IsarDatasource());
});

/// Proceso/troquel actualmente seleccionado en la UI
final selectedProcesoProvider = StateProvider<Proceso?>((_) => null);
