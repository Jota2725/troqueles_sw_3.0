import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/datasource/materiales.datasource.dart';
import 'package:troqueles_sw/domain/entities/materiales.dart';
import 'package:troqueles_sw/infrastructure/datasource/materiales_datasource.dart';
import '../../infrastructure/datasource/isar_datasource.dart';

class MaterialNotifier extends StateNotifier<List<Materiales>> {
  final IsarDatasource _isarDatasource;

  MaterialNotifier(this._isarDatasource) : super([]);


 Materiales? _selectedMaterial;
  Materiales? get selectedMaterial => _selectedMaterial;

  final List<Materiales> _selectedMaterials = [];
  List<Materiales> get selectedMaterials => List.unmodifiable(_selectedMaterials);
  // Cargar todos los materiales
  Future<void> loadMateriales() async {
    state = await _isarDatasource.gettAllMateriles();
  }

  Future<void> addMateriales(Materiales material) async {
    await _isarDatasource.addNewMaterial([material]);
  }

   void setSelectedMaterial(Materiales material) {
    _selectedMaterial = material;
    state = List.from(state); // Asegura que el cambio se notifique.
  }

  void addMaterialToSelected(Materiales material) {
    _selectedMaterials.add(material);
    // Notificar cambios solo si necesitas mostrar la lista en la UI
    state = List.from(state);
  }

  void clearSelectedMaterials() {
    _selectedMaterials.clear();
    state = List.from(state); // Notificar cambios.
  }


Future<void> addMaterialesFromList(List<Materiales> materiales) async {
    try {
      await _isarDatasource.addNewMaterial(materiales);
      // Recargar la lista de materiales después de agregar nuevos
      await loadMateriales();
    } catch (e) {
      // Manejar errores
      print('Error al agregar materiales desde la lista: $e');
    }
  }
  // Buscar materiales
  Future<void> searchMaterial(String query) async {
    final result = await _isarDatasource.gettAllMateriles(); // Ajusta la lógica según tu base de datos
    state = result;
  }
}



// Proveedor de la lista de materiales
final materialProvider =
    StateNotifierProvider<MaterialNotifier, List<Materiales>>((ref) {
  final isarDatasource = IsarDatasource();
  return MaterialNotifier(isarDatasource);
});

// Proveedor para el material seleccionado
final selectedMaterialProvider =
    StateProvider<Materiales?>((ref) => null);


final materialesDatasourceProvider = Provider<MaterialesDatasource>((ref) {
  return MaterialesDatasourceImpl();
});
