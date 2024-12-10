
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';
import '../../providers/troqueles_provider.dart';
import '../widgets.dart';
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
    final troquelNotifier = ref.read(troquelProvider.notifier);
    final troqueles = ref.watch(troquelProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ActionsBibliaco(
              maquina: maquina,
              troquelNotifier: troquelNotifier,
              onImportPressed: onImportPressed),
          _TablaTroqueles(
            troqueles: troqueles,
          ),
        ],
      ),
    );
  }
}

class ActionsBibliaco extends StatelessWidget {
  const ActionsBibliaco({
    super.key,
    required this.maquina,
    required this.troquelNotifier,
    required this.onImportPressed,
  });

  final String maquina;
  final TroquelNotifier troquelNotifier;
  final VoidCallback? onImportPressed;

  @override
  Widget build(BuildContext context) {
    return ActionsIcons(
      searchBar: CustomSearchBar(maquina),
      actions: [
        ActionIcon(
            label: 'Eliminar todos',
            icon: const Icon(Icons.delete_forever),
            onPressed: () =>
                troquelNotifier.deleteAllTroquelesbyMachine(maquina)),
        ActionIcon(
            label: 'Refrescar',
            icon: const Icon(Icons.refresh_outlined),
            onPressed: () => troquelNotifier.loadTroqueles(maquina)),
        ActionIcon(
            label: 'Agregar',
            icon: const Icon(Icons.add_circle),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AddTroquelees();
                  });
            }),
        ActionIcon(
            label: 'Importar Excel',
            icon: const Icon(Icons.upload),
            onPressed: onImportPressed!),
        ActionIcon(
            label: 'Ubicaciones libres',
            icon: const Icon(Icons.check_box_outline_blank),
            onPressed: () => troquelNotifier.loadTroquelesLibres(maquina))
      ],
    );
  }
}

class _TablaTroqueles extends ConsumerWidget {
  final List<Troquel> troqueles;

  const _TablaTroqueles({
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
            DataColumn(
                label: DataColums(icon: Icons.location_on, text: 'Ubicación')),
            DataColumn(
                label: DataColums(icon: Icons.numbers_sharp, text: 'GICO')),
            DataColumn(
                label:
                    DataColums(icon: Icons.factory_rounded, text: 'Cliente')),
            DataColumn(
                label: DataColums(
                    icon: Icons.onetwothree_rounded, text: 'Referencia')),
            DataColumn(
                label: DataColums(
                    icon: Icons.adf_scanner_rounded, text: 'Máquina')),
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
                      tooltip: 'Editar Troquel ',
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
                      tooltip: 'Eliminar Troquel ',
                      onPressed: () async {
                        final troquelNotifier =
                            ref.read(troquelProvider.notifier);
                        await troquelNotifier.deleteTroquel(
                            troquel.isarId!, troquel.maquina);
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
