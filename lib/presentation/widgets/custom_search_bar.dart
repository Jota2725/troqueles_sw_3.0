import 'package:flutter/material.dart';


class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      
      viewHintText: 'BUSCA EL TROQUEL DESEADO',
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          hintText: 'BUSCA EL TROQUEL DESEADO',
          elevation: const WidgetStatePropertyAll(0),
          controller: controller,
          
          padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 18.0)),
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
          leading: const Icon(Icons.search),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(5, (int index) {
          final String item = 'item $index';
          return ListTile(
            title: Text(item),
            onTap: () {
              controller.closeView(item);
            },
          );
        });
      },
    );
  }
}

