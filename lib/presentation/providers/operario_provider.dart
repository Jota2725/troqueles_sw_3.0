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
  OperarioNotifier(this._isarDatasource) : super([]);

  Future<void> loadOperario() async {
    await _isarDatasource.getAllOperarios();
  }
}
