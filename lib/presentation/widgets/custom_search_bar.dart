import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/troqueles_provider.dart';

class CustomSearchBar extends ConsumerWidget {
  final String maquina;
  const CustomSearchBar(
    this.maquina, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.read(troquelProvider.notifier);
    return SizedBox(
      width: 250,
      child: SearchAnchor(
        viewHintText: 'BUSCAR TROQUEL ',
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            hintText: 'BUSCAR  TROQUEL ',
            elevation: const WidgetStatePropertyAll(0),
            controller: controller,
            padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 18.0)),
            onTap: () {
              controller.openView();
            },
            onChanged: (query) async {
              if (query.isNotEmpty) {
                // Convertir el query a un número (GICO)
                final gico = int.tryParse(query);
                if (gico != null) {
                  // Realiza la búsqueda en el proveedor
                  await search.searchTroquel(gico, maquina);
                }
              } else {
                // Si el campo está vacío, recargar todos los troqueles
                await search.loadTroqueles(maquina);
              }
              controller.openView();
            },
            leading: const Icon(Icons.search),
            onSubmitted: (query) async {
              if (query.isNotEmpty && int.tryParse(query) != null) {
                final gico = int.parse(query);
                await search.searchTroquel(gico, maquina);
              } else {
                await search.loadTroqueles(maquina);
              }
            },
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          // Obtenemos los troqueles actuales en el estado
          final query = controller.text;
          if (query.isEmpty) {
            return [];
          }
          // Obtenemos los troqueles actuales en el estado
          final troqueles = ref.watch(troquelProvider);

          // Filtrar los troqueles que comienzan con el texto ingresado
          final filteredTroqueles = troqueles.where((troquel) {
            return troquel.gico.toString().startsWith(query);
          }).toList();

          // Construir la lista de sugerencias
          return filteredTroqueles.map((troquel) {
            return ListTile(
              title: Text('GICO: ${troquel.gico}, Cliente: ${troquel.cliente}'),
              onTap: () {
                // Cerrar la vista de búsqueda y mostrar el GICO seleccionado
                controller.closeView(troquel.gico.toString());
              },
            );
          }).toList();
        },
      ),
    );
  }
}
