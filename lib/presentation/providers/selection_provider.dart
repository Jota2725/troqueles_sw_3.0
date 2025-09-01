import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Troquel seleccionado para navegación/uso en formularios.
/// Mantengo el mismo tipo (Map<String, dynamic>) que ya usas en la app.
final selectedTroquelProvider =
    StateProvider<Map<String, dynamic>>((ref) => {});
