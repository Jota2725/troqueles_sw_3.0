import 'package:flutter/material.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';

class TroquelTable extends StatefulWidget {
  final List<Troquel> troqueles;
  final VoidCallback? onImportPressed;
  const TroquelTable(
      {super.key, required this.troqueles, this.onImportPressed});

  @override
  TroquelTableState createState() => TroquelTableState();
}

class TroquelTableState extends State<TroquelTable> {
  bool sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {},
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
          ),
          _TablaTroqueles(sortAscending: sortAscending, widget: widget),
        ],
      ),
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
          ],
          rows: widget.troqueles.map<DataRow>((Troquel troquel) {
            return DataRow(
              cells: <DataCell>[
                DataCell(Text('${troquel.ubicacion}'), onTap: () {}),
                DataCell(Text('${troquel.gico}'), onTap: () {}),
                DataCell(Text(troquel.cliente), onTap: () {}),
                DataCell(Text('${troquel.referencia}'), onTap: () {}),
                DataCell(Text(troquel.maquina), onTap: () {}),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DataColums extends StatelessWidget {
  final IconData icon;
  final String text;
  const DataColums({
    super.key,
    required this.icon,
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
