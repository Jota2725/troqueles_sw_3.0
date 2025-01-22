import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/operario.dart';


class SearchOperario extends ConsumerWidget {
  const SearchOperario({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SearchAnchor.bar(
      barHintText: 'Ingrese la ficha del Maestro Troquelero',
      viewBackgroundColor: Colors.black,
  suggestionsBuilder: (BuildContext context, SearchController controller) {
    final String input = controller.value.text.toLowerCase();

    // Lista de operarios (puedes reemplazarla con datos dinámicos)
    final List<Operario> operarios = [
      Operario(ficha:  2, nombre: 'Ana'),
      Operario(ficha:  3, nombre: 'Carlos'),
      Operario(ficha:  1, nombre: 'Juan'),
    ];

    // Filtrar operarios según el texto ingresado
    final filteredOperarios = operarios.where((operario) {
      final fullName = ' ficha:  ${operario.ficha}    ${operario.nombre} '.toLowerCase();
      return fullName.contains(input);
    });

    // Mapear resultados a widgets
    return filteredOperarios.map((operario) {
      return ListTile(
        title: Text(' ficha:  ${operario.ficha}    ${operario.nombre} '),
        onTap: (){
          print('Texto enviado: ${operario.ficha}, ${operario.nombre}  ');
        },
        
        // Aquí no necesitamos onTap, porque el manejo será al enviar
      );
    }).toList();
  },
  
    onSubmitted: (String value) {
      // Lógica al enviar el texto (al presionar Enter o buscar)
      print('Texto enviado: $value, ');
      
      // Aquí podrías buscar el operario exacto
      // y ejecutar la acción deseada
    }
    );

}
}