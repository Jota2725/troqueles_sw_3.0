import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/materiales.dart';

import '../../infrastructure/datasource/isar_datasource.dart';

class MaterialNotifier extends StateNotifier<List<Materiales>> {
  final IsarDatasource _isarDatasource;

  MaterialNotifier(this._isarDatasource) : super([]);

  // Inicializar y cargar troqueles por maquina
  Future<void> loadMateriales() async {
    state = await _isarDatasource.gettAllMateriles();
  }

  Materiales? _selectedMaterial;
  Materiales? get selectedMaterial => _selectedMaterial;

  void setSelectedMaterial(Materiales material) {
    _selectedMaterial = material;
  }

  // Agregar un nuevo troquel
  // Future<void> addTroquel(Troquel troquel) async {
  //   await _isarDatasource.saveTroqueles([troquel]);
  //   await loadTroqueles(troquel.maquina); // Recargar los troqueles por máquina
  // }
  // Future<void> addTroquelInprocess(Proceso proceso) async {
  //   await _isarDatasource.addNewTroquelInProcess([proceso]);
  //   final updatedList = await _isarDatasource.getAllTroquelesInProcess();
  // state = updatedList.cast<Troquel>(); // Recargar los troqueles por máquina
  // }

  Future<void> searchMaterial() async {
    final result = await _isarDatasource.gettAllMateriles();
    state = result;
    // Actualiza el estado con el troquel encontrado
  }

  // Actualizar un troquel existente
  // Future<void> updateTroquel(Troquel troquel) async {
  //   await _isarDatasource.updateTroquel(troquel);
  //   await loadTroqueles(troquel.maquina); // Recargar los troqueles por máquina
  // }

  // Eliminar un troquel por ID
//   Future<void> deleteTroquel(int id, String maquina) async {
//     await _isarDatasource.deleteTroquel(id);
//     await loadTroqueles(maquina); // Recargar los troqueles por máquina
//   }

//   Future<void> deleteAllTroquelesbyMachine(String maquina) async {
//     await _isarDatasource.deleteAllTroquelesbyMachine(maquina);
//     await loadTroqueles(maquina);
//   }
// Future<void> loadTroquelesLibres(String maquina) async {
//     final troquelesLibres = await _isarDatasource.getTroquelesLibres(maquina);
//     state = troquelesLibres; // Actualizar el estado con los troqueles libres específicos de la máquina
//   }
}

// Provider de TroquelNotifier
final materialProvider =
    StateNotifierProvider<MaterialNotifier, List<Materiales>>((ref) {
  final isarDatasource = IsarDatasource();
  return MaterialNotifier(isarDatasource);
});
