import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/datasource/materiales.datasource.dart';
import 'package:troqueles_sw/domain/entities/materiales.dart';
import 'package:troqueles_sw/infrastructure/datasource/materiales_datasource.dart';
import 'package:troqueles_sw/infrastructure/datasource/sqlite/sqlite_datasource.dart';

class MaterialNotifier extends StateNotifier<List<Materiales>> {
  final SqliteDatasource _sqlite;

  MaterialNotifier(this._sqlite) : super([]) {
    loadMateriales();
  }

  Materiales? _selectedMaterial;
  Materiales? get selectedMaterial => _selectedMaterial;

  final List<Materiales> _selectedMaterials = [];
  List<Materiales> get selectedMaterials =>
      List.unmodifiable(_selectedMaterials);

  Future<void> loadMateriales() async {
    state = await _sqlite.gettAllMateriles();
  }

  Future<void> addMateriales(Materiales material) async {
    await _sqlite.addNewMaterial([material]);
    await loadMateriales();
  }

  Future<void> addMaterialesFromList(List<Materiales> materiales) async {
    await _sqlite.addNewMaterial(materiales);
    await loadMateriales();
  }

  Future<void> deleteMaterial(Materiales material) async {
    if (material.isarId != null) {
      await _sqlite.deleteMaterialById(material.isarId!);
      await loadMateriales();
    }
  }

  void setSelectedMaterial(Materiales material) {
    _selectedMaterial = material;
    state = List.from(state);
  }

  void addMaterialToSelected(Materiales material) {
    _selectedMaterials.add(material);
    state = List.from(state);
  }

  void clearSelectedMaterials() {
    _selectedMaterials.clear();
    state = List.from(state);
  }

  Future<void> searchMaterial(String query) async {
    final result = await _sqlite.gettAllMateriles();
    state = result; // (si luego añades filtro por query, lo aplicas aquí)
  }
}

final materialProvider =
    StateNotifierProvider<MaterialNotifier, List<Materiales>>((ref) {
  return MaterialNotifier(SqliteDatasource.instance);
});

final selectedMaterialProvider = StateProvider<Materiales?>((ref) => null);

final materialesDatasourceProvider = Provider<MaterialesDatasource>((ref) {
  return MaterialesDatasourceImpl();
});
