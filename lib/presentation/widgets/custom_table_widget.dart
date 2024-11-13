import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';
import 'package:troqueles_sw/presentation/widgets/add_troquelees.dart';
import '../../infrastructure/datasource/isar_datasource.dart';
import '../providers/troqueles_provider.dart';
import 'actionIcons.dart';
 // Asegúrate de importar el provider aquí

class TroquelTable extends ConsumerWidget {
  final VoidCallback? onImportPressed;
  final String maquina;

  const TroquelTable({
    super.key,
    this.onImportPressed,
    required this.maquina,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final troqueles = ref.watch(troquelProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ActionsIcons(
            isarDatasource: IsarDatasource(),
            widget: this,
          ),
          FadeInUp(
            child: _TablaTroqueles(troqueles: troqueles,),
          ),
        ],
      ),
    );
  }
}

class _TablaTroqueles extends ConsumerWidget {
  final List<Troquel> troqueles;

  const _TablaTroqueles({
    super.key,
    required this.troqueles,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        child: DataTable(
          dividerThickness: 0,
          sortColumnIndex: 0,
          onSelectAll: (value) => true,
          columns: const <DataColumn>[
            DataColumn(label: DataColums(icon: Icons.location_on, text: 'Ubicación')),
            DataColumn(label: DataColums(icon: Icons.numbers_sharp, text: 'GICO')),
            DataColumn(label: DataColums(icon: Icons.factory_rounded, text: 'Cliente')),
            DataColumn(label: DataColums(icon: Icons.onetwothree_rounded, text: 'Referencia')),
            DataColumn(label: DataColums(icon: Icons.adf_scanner_rounded, text: 'Máquina')),
            DataColumn(label: DataColums(text: '')),
          ],
          rows: troqueles.map<DataRow>((Troquel troquel) {
            return DataRow(
              cells: <DataCell>[
                DataCell(Text('${troquel.ubicacion}')),
                DataCell(Text('${troquel.gico}')),
                DataCell(Text(troquel.cliente)),
                DataCell(Text('${troquel.referencia}')),
                DataCell(Text(troquel.maquina)),
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
                          },
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        final troquelNotifier = ref.read(troquelProvider.notifier);
                        await troquelNotifier.deleteTroquel(troquel.isarId!,troquel.maquina );
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    )
                  ],
                )),
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
          Icon(icon),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
