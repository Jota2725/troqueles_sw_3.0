import 'package:flutter/material.dart';

class TroquelSearchDelegate extends SearchDelegate {
  final List<String> proceso; // Lista de troqueles para buscar
  final void Function(String proceso) onSelected; // Acción al seleccionar un troquel

  TroquelSearchDelegate({required this.proceso, required this.onSelected});

  @override
  String get searchFieldLabel => 'Buscar troquel';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Botón para limpiar la búsqueda
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Botón para cerrar el SearchDelegate
    return IconButton(
      onPressed: () {
        close(context, null); // Cierra el SearchDelegate
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Mostrar resultados finales de búsqueda
    final results = proceso
        .where((proceso) => proceso.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          'No se encontraron resultados para "$query".',
          style: const TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final proceso = results[index];
        return ListTile(
          title: Text(proceso),
          onTap: () {
            onSelected(proceso); // Llama a la función al seleccionar
            close(context, null);
          },
        );
      },
    );
  }

  Widget _emptyContainer() {
    return const Center(
      child: Icon(
        Icons.search,
        
        size: 150,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Mostrar sugerencias mientras se escribe en el campo de búsqueda
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final suggestions = proceso
        .where((proceso) => proceso.toLowerCase().contains(query.toLowerCase()))
        .toList();

        

    if (suggestions.isEmpty) {
      return Center(
        child: Text(
          'No hay sugerencias para "$query".',
          style: const TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          hoverColor: const Color(0xFF0BAFFE),  
          title: Text(suggestion ),
          onTap: () {
            query = suggestion; // Actualiza la búsqueda con el sugerido
            showResults(context); // Muestra los resultados
          },
        );
      },
    );
  }
}
