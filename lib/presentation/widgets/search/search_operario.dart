import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/operario_provider.dart'; // Importa el provider correctamente

class SearchOperario extends ConsumerWidget {
  const SearchOperario({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final operarioNotifier = ref.read(operarioProvider.notifier);

    // Cargar operarios al iniciar

    return SearchAnchor.bar(
      barHintText: 'Ingrese la ficha del Maestro Troquelero',
      viewBackgroundColor: Colors.black,
      suggestionsBuilder:
          (BuildContext context, SearchController controller) async {
        await operarioNotifier.loadOperario();

        final operarioss = ref.read(operarioProvider);
        final String input = controller.value.text.toLowerCase();

        // Filtrar operarios según el texto ingresado
        final filteredOperarios = operarioss.where((operario) {
          final fullName =
              'ficha: ${operario.ficha} ${operario.nombre}'.toLowerCase();
          return fullName.contains(input);
        });

        // Mapear resultados a widgets
        return filteredOperarios.map((operario) {
          return ListTile(
            title: Text('Ficha: ${operario.ficha} - ${operario.nombre}'),
            onTap: () {
              print('Texto enviado: ${operario.ficha}, ${operario.nombre}');
            },
          );
        }).toList();
      },
      onSubmitted: (String value) {
        print('Texto enviado: $value');
      },
    );
  }
}
