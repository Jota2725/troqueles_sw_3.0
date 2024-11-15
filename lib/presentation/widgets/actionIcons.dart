import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/datasource/isar_datasource.dart';
import '../providers/troqueles_provider.dart';
import 'add_troquelees.dart';
import 'custom_search_bar.dart';
import 'custom_table_widget.dart';

class ActionsIcons extends ConsumerWidget {
  const ActionsIcons({
    super.key,
    required this.isarDatasource,
    required this.widget,
  });

  final IsarDatasource isarDatasource;
  final TroquelTable widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final troquelNotifier = ref.read(troquelProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         CustomSearchBar(widget.maquina),

                                                //Eliminar todos
        //------------------------------------------------------------------------------------------------------------------------
        TextButton.icon(
          onPressed: () {
              troquelNotifier.deleteAllTroquelesbyMachine(widget.maquina);
          },
          label: const Text('Eliminar todos'),
          icon: const Icon(Icons.delete_forever),
          iconAlignment: IconAlignment.end,
        ),
                                                  //BOTON ACTUALIZAR
        //------------------------------------------------------------------------------------------------------------------------
        TextButton.icon(
          onPressed: () {
           troquelNotifier.loadTroqueles(widget.maquina);
          },
          label: const Text('Refrescar '),
          icon: const Icon(Icons.refresh_outlined),
          iconAlignment: IconAlignment.end,
        ),

                                              //BOTON AGREGAR
        //------------------------------------------------------------------------------------------------------------------------
        TextButton.icon(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AddTroquelees();
                });
          },
          label: const Text('Agregar'),
          icon: const Icon(Icons.add_circle),
          iconAlignment: IconAlignment.end,
        ),

                                              //BOTON GUARDAR 
        //---------------------------------------------------------------------------------------------------

        TextButton.icon(
          onPressed: () {
            troquelNotifier.loadTroquelesLibres(widget.maquina);
          },
          label: const Text('Libres'),
          icon: const Icon(Icons.check_box_outline_blank),
          iconAlignment: IconAlignment.end,
        ),

                                                // BOTON IMPORTAR EXCEL
        //----------------------------------------------------------------------------------------------------------
        TextButton.icon(
          onPressed: widget.onImportPressed,
          label: const Text('Importar excel'),
          icon: const Icon(Icons.upload),
          iconAlignment: IconAlignment.end,
        ),
      ],
    );
  }
}