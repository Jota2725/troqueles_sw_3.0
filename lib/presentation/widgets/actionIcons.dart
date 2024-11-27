import 'package:flutter/material.dart';

typedef ActionCallback = void Function();

class ActionIcon {
  final String label;
  final Icon icon;
  final ActionCallback onPressed;

  ActionIcon({
    required this.label,
    required this.icon,
    required this.onPressed,
  });
}

class ActionsIcons extends StatelessWidget {
  final List<ActionIcon> actions;
  final Widget? searchBar;

  const ActionsIcons({
    super.key,
    required this.actions,
    this.searchBar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        searchBar ?? const SizedBox() ,
        ...actions.map((action) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton.icon(
              onPressed: action.onPressed,
              label: Text(action.label),
              icon: action.icon,
              iconAlignment: IconAlignment.end,
            ),
          );
        }).toList(),
      ],
    );
  }
}






















        /*
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

        //TODO ME FALTA AGREGAR EL EXPORTAR EXCEL Y IMPRIMIR BIBIBLIACO 


      ],
    );
  }
  */

