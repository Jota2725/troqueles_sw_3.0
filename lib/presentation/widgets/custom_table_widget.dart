import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';
import 'package:troqueles_sw/presentation/widgets/add_troquelees.dart';

import '../../infrastructure/datasource/isar_datasource.dart';
import 'custom_search_bar.dart';

class TroquelTable extends StatefulWidget {
  final List<Troquel> troqueles;
  final VoidCallback? onImportPressed;
  final String maquina;

  const TroquelTable({
    super.key,
    required this.troqueles,
    this.onImportPressed,
    required this.maquina,
  });

  @override
  TroquelTableState createState() => TroquelTableState();
}

class TroquelTableState extends State<TroquelTable> {
  bool sortAscending = true;
  final IsarDatasource isarDatasource = IsarDatasource();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ActionsIcons(isarDatasource: isarDatasource, widget: widget),
          FadeInUp(
              child: _TablaTroqueles(
                  sortAscending: sortAscending, widget: widget)),
        ],
      ),
    );
  }
}

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

        TextButton.icon(
          onPressed: () {
            isarDatasource.deleteAllTroquelesbyMachine(widget.maquina);
          },
          label: const Text('Eliminar todos'),
          icon: const Icon(Icons.delete_forever),
          iconAlignment: IconAlignment.end,
        ),

        TextButton.icon(
          onPressed: () {},
          label: const Text('Actualizar'),
          icon: const Icon(Icons.refresh_outlined),
          iconAlignment: IconAlignment.end,
        ),

        //BOTON AGREGAR
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

        TextButton.icon(
          onPressed: () {},
          label: const Text('Guardar'),
          icon: const Icon(Icons.save),
          iconAlignment: IconAlignment.end,
        ),
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

class _TablaTroqueles extends StatelessWidget {
  const _TablaTroqueles({
    required this.sortAscending,
    required this.widget,
  });

  final bool sortAscending;
  final TroquelTable widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        child: DataTable(
          dividerThickness: 0,
          sortColumnIndex: 0,
          sortAscending: sortAscending,
          onSelectAll: (value) => true,
          columns: const <DataColumn>[
            DataColumn(
                label: DataColums(
              icon: Icons.location_on,
              text: 'Ubicacion',
            )),
            DataColumn(
                label: DataColums(
              icon: Icons.numbers_sharp,
              text: 'Gico',
            )),
            DataColumn(
                label: DataColums(
              icon: Icons.factory_rounded,
              text: 'Cliente',
            )),
            DataColumn(
                label: DataColums(
              icon: Icons.onetwothree_rounded,
              text: 'Referencia',
            )),
            DataColumn(
                label: DataColums(
              icon: Icons.adf_scanner_rounded,
              text: 'Maquina',
            )),
            DataColumn(label: DataColums(text: ''))
          ],
          rows: widget.troqueles.map<DataRow>((Troquel troquel) {
            return DataRow(
              cells: <DataCell>[
                DataCell(Text('${troquel.ubicacion}'), onTap: () {}),
                DataCell(Text('${troquel.gico}'), onTap: () {}),
                DataCell(Text(troquel.cliente), onTap: () {}),
                DataCell(Text('${troquel.referencia}'), onTap: () {}),
                DataCell(Text(troquel.maquina), onTap: () {}),
                DataCell(Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddTroquelees(
                                  troquel: troquel,
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.edit,
                        )),
                    IconButton(
                      onPressed: () {
<<<<<<< HEAD
                        final IsarDatasource isarDatasource = IsarDatasource();
                        isarDatasource.deleteTroquel(troquel.isarId!);


=======

                        
>>>>>>> 71e727c21c07db690bc7f4eb1801938066d7aee5
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                ))
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DataColums extends StatelessWidget {
  final IconData? icon;
  final String text;
  const DataColums({
    super.key,
    this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Icon(
            icon,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: const TextStyle(

                //rgb(11, 175, 254) otro color
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
