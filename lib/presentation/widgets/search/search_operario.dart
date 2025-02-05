import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/operario_provider.dart';

class SearchOperario extends ConsumerWidget {
  const SearchOperario({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Leer la lista de operarios de forma reactiva
    final operarios = ref.watch(operarioProvider);
    final operarioNotifier = ref.read(operarioProvider.notifier);

    // Cargar operarios si la lista está vacía
    if (operarios.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        operarioNotifier.loadOperario();
      });
    }

    return SearchAnchor.bar(
      barHintText: 'Ingrese la ficha del Maestro Troquelero',
      viewBackgroundColor: Colors.black,
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        final String input = controller.value.text.toLowerCase().trim();

        // Filtrar operarios según el texto ingresado
        final filteredOperarios = operarios.where((operario) {
          final fullName = 'ficha: ${operario.ficha} ${operario.nombre}'.toLowerCase();
          return fullName.contains(input);
        }).toList();

        // Si no hay resultados, mostrar un mensaje
        if (filteredOperarios.isEmpty) {
          return [
            const ListTile(
              title: Text('No se encontraron coincidencias'),
            ),
          ];
        }

        return filteredOperarios.map((operario) {
          return ListTile(
            title: Text('Ficha: ${operario.ficha} - ${operario.nombre}'),
            onTap: () {
              ref.read(selectedOperarioProvider.notifier).state = operario;
              controller.closeView(operario.ficha.toString());
              print('Texto enviado: ${operario.ficha}, ${operario.nombre}');
            },
          );
        }).toList();
      },
    );
  }
}
