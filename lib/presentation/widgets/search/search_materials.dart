import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/materials_provider.dart';

class SearchMaterials extends ConsumerWidget {
  const SearchMaterials({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materiales = ref.watch(materialProvider);
    final materialesNotifier = ref.read(materialProvider.notifier);

    return SizedBox(
      width: double.infinity,
      child: SearchAnchor(
        viewBackgroundColor: Colors.black,
        viewHintText: 'Buscar material por código',
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            hintText: 'Buscar material por código',
            elevation: const WidgetStatePropertyAll(0),
            controller: controller,
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 5.0),
            ),
            leading: const Icon(Icons.search),
            onChanged: (query) async {
              await _buscarMaterial(query, materialesNotifier);
              controller.openView();
            },
            onTap: () async {
              if (materiales.isEmpty) {
                await materialesNotifier.loadMateriales();
              }
              controller.openView();
            },
            onSubmitted: (query) async {
              await _buscarMaterial(query, materialesNotifier);
              controller.openView();
            },
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          final query = controller.text.trim();
          if (query.isEmpty) {
            return const [];
          }

          // Filtrar materiales dinámicamente
          final filteredMaterials = materiales.where((material) {
            return material.codigo.toString().contains(query);
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
                'Código: ${material.codigo}\n'
                'Material: ${_truncarDescripcion(material.descripcion, 50)}\n'
                'Tipo: ${material.tipo.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                ref.read(selectedMaterialProvider.notifier).state = material;
                controller.closeView(material.codigo.toString());
              },
            );
          }).toList();
        },
      ),
    );
  }

  /// Lógica centralizada para buscar materiales
  Future<void> _buscarMaterial(String query, MaterialNotifier notifier) async {
    if (query.isNotEmpty && int.tryParse(query) != null) {
      await notifier.searchMaterial(query);
    } else {
      await notifier.loadMateriales();
    }
  }

  /// Método para truncar descripciones largas
  String _truncarDescripcion(String descripcion, int maxChars) {
    if (descripcion.length <= maxChars) {
      return descripcion;
    }
    return '${descripcion.substring(0, maxChars)}...';
  }
}
