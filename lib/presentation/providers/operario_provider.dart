import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/operario.dart';
import '../../infrastructure/datasource/isar_datasource.dart';

final operarioProvider =
    StateNotifierProvider<OperarioNotifier, List<Operario>>((ref) {
  final isarDatasource = IsarDatasource();
  return OperarioNotifier(isarDatasource);
});

class OperarioNotifier extends StateNotifier<List<Operario>> {
  final IsarDatasource _isarDatasource;

  Operario? _selectedOperario;
  Operario? get selectedOperario => _selectedOperario;

  OperarioNotifier(this._isarDatasource) : super([]);

  /// 🔹 Cargar operarios desde la base de datos
  Future<void> loadOperario() async {
    final operarios = await _isarDatasource.getAllOperarios();
    state = operarios; // ✅ Se actualiza la lista en Riverpod
  }

  /// 🔹 Agregar nuevo operario y actualizar la lista
  Future<void> addNewOperarios(Operario operario) async {
    await _isarDatasource.addNewOperarios([operario]);
    await loadOperario(); // ✅ Recargar lista después de agregar
  }
}

// 🔹 Proveedor de operario seleccionado
final selectedOperarioProvider = StateProvider<Operario?>((ref) => null);
