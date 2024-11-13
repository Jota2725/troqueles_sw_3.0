import 'package:flutter/material.dart';

import '../../infrastructure/datasource/isar_datasource.dart';
import 'add_troquelees.dart';
import 'custom_search_bar.dart';
import 'custom_table_widget.dart';

class ActionsIcons extends StatelessWidget {
  const ActionsIcons({
    super.key,
    required this.isarDatasource,
    required this.widget,
  });

  final IsarDatasource isarDatasource;
  final TroquelTable widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomSearchBar(),

                                                //Eliminar todos
        //------------------------------------------------------------------------------------------------------------------------
        TextButton.icon(
          onPressed: () {
            isarDatasource.deleteAllTroquelesbyMachine(widget.maquina);
          },
          label: const Text('Eliminar todos'),
          icon: const Icon(Icons.delete_forever),
          iconAlignment: IconAlignment.end,
        ),
                                                  //BOTON ACTUALIZAR
        //------------------------------------------------------------------------------------------------------------------------
        TextButton.icon(
          onPressed: () {},
          label: const Text('Actualizar'),
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
          onPressed: () {},
          label: const Text('Guardar'),
          icon: const Icon(Icons.save),
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