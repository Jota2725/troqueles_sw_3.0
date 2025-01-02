import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/materiales.dart';
import '../../infrastructure/datasource/isar_datasource.dart';

class MaterialNotifier extends StateNotifier<List<Materiales>> {
  final IsarDatasource _isarDatasource;

  MaterialNotifier(this._isarDatasource) : super([]);

  Materiales? _selectedMaterial;
  Materiales? get selectedMaterial => _selectedMaterial;

  // Cargar todos los materiales
  Future<void> loadMateriales() async {
    state = await _isarDatasource.gettAllMateriles();
  }

  // Establecer el material seleccionado
  void setSelectedMaterial(Materiales material) {
    _selectedMaterial = material;
    // Notificar el cambio de estado. No es necesario recargar toda la lista.
    state = List.from(state); // Esto asegura que el cambio se notifique.
  }

  // Buscar materiales (puedes ajustar según el criterio de búsqueda)
  Future<void> searchMaterial(String query) async {
    final result = await _isarDatasource.gettAllMateriles(); // Ajustar lógica de búsqueda según la base de datos
    state = result;
  }
}

// Provider de MaterialNotifier
final materialProvider =
    StateNotifierProvider<MaterialNotifier, List<Materiales>>((ref) {
  final isarDatasource = IsarDatasource();
  return MaterialNotifier(isarDatasource);
});
