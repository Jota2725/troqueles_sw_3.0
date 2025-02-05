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

  final List<Operario> selectOperario = [];
  List<Operario> get selectedOpeario => List.unmodifiable(selectOperario);



  OperarioNotifier(this._isarDatasource) : super([]);

  Future<void> loadOperario() async {
    final operarios = await _isarDatasource.getAllOperarios();
    state = operarios; // ✅ Ahora el estado se actualiza correctamente
  }

  Future<void>addNewOperarios(operario)async{
    await _isarDatasource.addNewOperarios([operario]);
  }
}
final selectedOperarioProvider =
    StateProvider<Operario?>((ref) => null);
