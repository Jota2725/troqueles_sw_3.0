import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/operario.dart';
import 'package:troqueles_sw/infrastructure/datasource/sqlite/sqlite_datasource.dart';

final operarioProvider =
    StateNotifierProvider<OperarioNotifier, List<Operario>>((ref) {
  return OperarioNotifier(SqliteDatasource.instance);
});

class OperarioNotifier extends StateNotifier<List<Operario>> {
  final SqliteDatasource _sqlite;

  Operario? _selectedOperario;
  Operario? get selectedOperario => _selectedOperario;

  OperarioNotifier(this._sqlite) : super([]);

  Future<void> loadOperario() async {
    state = await _sqlite.getAllOperarios();
  }

  Future<void> addNewOperarios(Operario operario) async {
    await _sqlite.addNewOperarios([operario]);
    await loadOperario();
  }
}

final selectedOperarioProvider = StateProvider<Operario?>((ref) => null);
