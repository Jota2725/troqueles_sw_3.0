import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';
import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';

class TroquelNotifier extends StateNotifier<List<Troquel>> {
  final IsarDatasource _isarDatasource;

  TroquelNotifier(this._isarDatasource) : super([]);

  // Inicializar y cargar troqueles por maquina
  Future<void> loadTroqueles(String maquina) async {
    state = await _isarDatasource.getAllTroquelesPorMaquina(maquina);
  }

  // Agregar un nuevo troquel
  Future<void> addTroquel(Troquel troquel) async {
    await _isarDatasource.saveTroqueles([troquel]);
    await loadTroqueles(troquel.maquina); // Recargar los troqueles por máquina
  }


  Future<void> searchTroquel(int gico, String maquina) async {
    final result = await _isarDatasource.getTroquelByGicoAndMaquina(gico, maquina);
    if (result != null) {
      state = [result];
       // Actualiza el estado con el troquel encontrado
    } else {
      state = []; // Limpia el estado si no se encuentra el troquel
    }
    
  }

  // Actualizar un troquel existente
  Future<void> updateTroquel(Troquel troquel) async {
    await _isarDatasource.updateTroquel(troquel);
    await loadTroqueles(troquel.maquina); // Recargar los troqueles por máquina
  }

  // Eliminar un troquel por ID
  Future<void> deleteTroquel(int id, String maquina) async {
    await _isarDatasource.deleteTroquel(id);
    await loadTroqueles(maquina); // Recargar los troqueles por máquina
  }
}

// Provider de TroquelNotifier
final troquelProvider = StateNotifierProvider<TroquelNotifier, List<Troquel>>((ref) {
  final isarDatasource = IsarDatasource();
  return TroquelNotifier(isarDatasource);
});
