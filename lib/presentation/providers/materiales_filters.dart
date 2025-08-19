import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/materiales.dart';
import 'package:troqueles_sw/presentation/providers/materials_provider.dart';

/// Texto de búsqueda
final materialSearchProvider = StateProvider<String>((_) => '');

/// Filtro por tipo. `null` = Todos
final materialTipoFilterProvider = StateProvider<Tipo?>((_) => null);

/// Lista filtrada combinando búsqueda + tipo.
/// Usa tu provider existente `materialProvider` que ya trae la lista completa.
final filteredMaterialesProvider = Provider<List<Materiales>>((ref) {
  final all = ref.watch(materialProvider); // <-- tu lista completa
  final query = ref.watch(materialSearchProvider).trim().toLowerCase();
  final tipoSel = ref.watch(materialTipoFilterProvider);

  return all.where((m) {
    final byType = (tipoSel == null) || m.tipo == tipoSel;
    if (query.isEmpty) return byType;

    final q = query;
    final hits = m.codigo.toString().toLowerCase().contains(q) ||
        m.descripcion.toLowerCase().contains(q) ||
        m.unidad.name.toLowerCase().contains(q) ||
        m.tipo.name.toLowerCase().contains(q);

    return byType && hits;
  }).toList();
});
