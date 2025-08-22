import 'package:flutter/material.dart';

class TroquelSearchDelegate extends SearchDelegate<String> {
  final List<String> proceso;
  final Function(String) onSelected;

  TroquelSearchDelegate({
    required this.proceso,
    required this.onSelected,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // cerramos sin devolver nada
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = proceso
        .where((p) => p.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          title: Text(item),
          onTap: () {
            onSelected(item);
            close(context, item); // devolvemos el valor seleccionado
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = proceso
        .where((p) => p.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        return ListTile(
          title: Text(item),
          onTap: () {
            onSelected(item);
            close(context, item); // devolvemos el valor seleccionado
          },
        );
      },
    );
  }
}
