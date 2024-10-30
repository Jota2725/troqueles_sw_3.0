import 'package:flutter/material.dart';
import 'package:troqueles_sw/domain/entities/troqueles.dart';

class TroquelTable extends StatefulWidget {
  const TroquelTable({super.key});

  @override
  _TroquelTableState createState() => _TroquelTableState();
}

class _TroquelTableState extends State<TroquelTable> {
  final List<Troquel> _listTroquel = [
    Troquel(432, 3566, 'Agro', 18476301, 'WARD'),
    Troquel(434, 3587, 'Bivien', 18547701, 'WARD'),
    Troquel(567, 3566, 'Agro', 18375001, 'WARD'),
    Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
    Troquel(907, 3566, 'Agro', 18375001, 'WARD'),
    Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
    Troquel(432, 3566, 'Agro', 18476301, 'WARD'),
    Troquel(434, 3587, 'Bivien', 18547701, 'WARD'),
    Troquel(567, 3566, 'Agro', 18375001, 'WARD'),
    Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
    Troquel(907, 3566, 'Agro', 18375001, 'WARD'),
    Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
    Troquel(432, 3566, 'Agro', 18476301, 'WARD'),
    Troquel(434, 3587, 'Bivien', 18547701, 'WARD'),
    Troquel(567, 3566, 'Agro', 18375001, 'WARD'),
    Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
    Troquel(907, 3566, 'Agro', 18375001, 'WARD'),
    Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
  ];

  bool sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Material(
              child: DataTable(
                sortColumnIndex: 0,
                sortAscending: sortAscending,
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
                rows: _listTroquel.map<DataRow>((Troquel troquel) {
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
          ),
        ],
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
