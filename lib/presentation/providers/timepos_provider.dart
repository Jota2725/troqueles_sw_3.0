

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/tiempos.dart';
import '../../infrastructure/datasource/isar_datasource.dart';




final timeProvider =
    StateNotifierProvider<TiemposNotifier, List<Tiempos>>((ref) {
  final isarDatasource = IsarDatasource();
  return TiemposNotifier(   isarDatasource);
});

class TiemposNotifier extends StateNotifier<List<Tiempos>> {
  final IsarDatasource _isarDatasource;
  TiemposNotifier(this._isarDatasource) : super([]);


   Future<void> loadTiempos() async {
    state = await _isarDatasource.getAllTiempos();
  }

  Future<void> addTiempos(Tiempos tiempo) async {
    await _isarDatasource.addNewTiempo([tiempo]);
    // Actualizar la lista de consumos después de agregar
    state = [...state, tiempo];
  }

  
}