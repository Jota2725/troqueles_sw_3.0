import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/datasource/materiales.datasource.dart';
import 'package:troqueles_sw/domain/entities/materiales.dart';
import 'package:troqueles_sw/infrastructure/datasource/materiales_datasource.dart';
import '../../infrastructure/datasource/isar_datasource.dart';

class MaterialNotifier extends StateNotifier<List<Materiales>> {
  final IsarDatasource _isarDatasource;

  MaterialNotifier(this._isarDatasource) : super([]) {
    loadMateriales();
  }

  Materiales? _selectedMaterial;
  Materiales? get selectedMaterial => _selectedMaterial;

  final List<Materiales> _selectedMaterials = [];
  List<Materiales> get selectedMaterials =>
      List.unmodifiable(_selectedMaterials);

  // ✅ Cargar todos los materiales
  Future<void> loadMateriales() async {
    state = await _isarDatasource.gettAllMateriles();
  }

  // ✅ Agregar material y recargar lista
  Future<void> addMateriales(Materiales material) async {
    await _isarDatasource.addNewMaterial([material]);
    await loadMateriales();
  }

  // ✅ Agregar varios materiales y recargar
  Future<void> addMaterialesFromList(List<Materiales> materiales) async {
    try {
      await _isarDatasource.addNewMaterial(materiales);
      await loadMateriales();
    } catch (e) {
      print('Error al agregar materiales desde la lista: $e');
    }
  }

  Future<void> deleteMaterial(Materiales material) async {
    if (material.isarId != null) {
      await _isarDatasource.deleteMaterialById(material.isarId!);
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
    final result = await _isarDatasource.gettAllMateriles();
    state = result;
  }
}

final materialProvider =
    StateNotifierProvider<MaterialNotifier, List<Materiales>>((ref) {
  final isarDatasource = IsarDatasource();
  return MaterialNotifier(isarDatasource);
});

// Proveedor para el material seleccionado
final selectedMaterialProvider = StateProvider<Materiales?>((ref) => null);

// Proveedor de datasource para importación desde Excel
final materialesDatasourceProvider = Provider<MaterialesDatasource>((ref) {
  return MaterialesDatasourceImpl();
});
