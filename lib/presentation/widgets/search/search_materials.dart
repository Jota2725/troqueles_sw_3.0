import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/materials_provider.dart';

class SearchMaterials extends ConsumerWidget {
  const SearchMaterials({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materiales = ref.watch(materialProvider);
    final materialesNotifier = ref.read(materialProvider.notifier);

    // Escuchar cambios en la lista de materiales y recargar si hay modificaciones
    ref.listen(materialProvider, (previous, next) {
      if (previous != next) {
        materialesNotifier.loadMateriales();
      }
    });

    return SearchAnchor.bar(
      barHintText: 'Buscar material por código',
      viewBackgroundColor: Colors.black,
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        final String input = controller.value.text.toLowerCase().trim();

        // Filtrar materiales dinámicamente
        final filteredMaterials = materiales.where((material) {
          final codigoMaterial = material.codigo.toString().toLowerCase();
          return codigoMaterial.contains(input);
        }).toList();

        if (filteredMaterials.isEmpty) {
          return [
            const ListTile(
              title: Text('No se encontraron materiales.'),
            ),
          ];
        }

        return filteredMaterials.map((material) {
          return ListTile(
            title: Text(
              'Código: ${material.codigo} - ${_truncarDescripcion(material.descripcion, 50)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text('Tipo: ${material.tipo.name}'),
            onTap: () {
              ref.read(selectedMaterialProvider.notifier).state = material;
              controller.closeView(material.codigo.toString());
            },
          );
        }).toList();
      },
    );
  }

  /// Método para truncar descripciones largas
  String _truncarDescripcion(String descripcion, int maxChars) {
    if (descripcion.length <= maxChars) {
      return descripcion;
    }
    return '${descripcion.substring(0, maxChars)}...';
  }
}
