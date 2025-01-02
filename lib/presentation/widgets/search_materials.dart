  import 'package:flutter/material.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';

  import '../providers/materials_provider.dart';

  class SearchMaterials extends ConsumerWidget {
    const SearchMaterials({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      final materiales = ref.watch(materialProvider);
      final materialesNotifier = ref.read(materialProvider.notifier);

      return SizedBox(
        width: double.infinity,
        child: SearchAnchor(
          viewHintText: 'Buscar material por código',
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              hintText: 'Buscar material por código',
              elevation: const WidgetStatePropertyAll(0),
              controller: controller,
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 5.0)),
              leading: const Icon(Icons.search),

              // Consolidamos la búsqueda aquí
              onChanged: (query) async {
                await _buscarMaterial(query, materialesNotifier);
                controller.openView();
              },
              onTap: () async {
                // Precargar materiales si aún no se han cargado
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

          // Generar sugerencias dinámicas
          suggestionsBuilder: (BuildContext context, SearchController controller) {
            final query = controller.text;
            if (query.isEmpty) {
              return const [];
            }

            // Filtrar materiales dinámicamente
            final filteredMaterials = materiales.where((material) {
              return material.codigo.toString().contains(query);
            }).toList();

            return filteredMaterials.map((material) {
              return ListTile(
                title: Text(
                  'Código: ${material.codigo} '
                  'Material: ${_truncarDescripcion(material.descripcion, 5)} '
                  'Tipo: ${material.tipo.name}',
                ),
                onTap: () {
                  ref.read(materialProvider.notifier).setSelectedMaterial(material);
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
    String _truncarDescripcion(String descripcion, int maxPalabras) {
      final palabras = descripcion.split(' ');
      return (palabras.length > maxPalabras)
          ? '${palabras.sublist(0, maxPalabras).join(' ')}...'
          : descripcion;
    }
  }
