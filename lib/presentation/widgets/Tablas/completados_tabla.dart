import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';
import '../../providers/completados_provider.dart';

import '../widgets.dart';

class CompletadosTable extends ConsumerWidget {
  const CompletadosTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completados = ref.watch(troquelProviderCompletados);
    final completadosNotifier = ref.watch(troquelProviderCompletados.notifier);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ActionsIcons(
            searchBar: const CustomSearchBar('Buscar completados'),
            actions: [
              ActionIcon(
                  label: 'Refrescar',
                  icon: const Icon(Icons.refresh_outlined),
                  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                  onPressed: () => completadosNotifier.state = completados),
            ],
          ),
          _TablaCompletados(completados: completados),
        ],
      ),
    );
  }
}

class _TablaCompletados extends StatelessWidget {
  const _TablaCompletados({required this.completados});

  final List<Proceso> completados;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 100,
      child: Material(
        child: PaginatedDataTable(
        
          showEmptyRows: false,
          showFirstLastButtons: true,
          columnSpacing: 12, // Reduce el espacio entre columnas
          horizontalMargin: 5,
          source: CompletadosDataRow(completados),
          rowsPerPage: 20,
          sortColumnIndex: 0,
          sortAscending: true,
          columns: const <DataColumn>[
            DataColumn(label: DataColums(icon: Icons.numbers, text: 'Troquel')),
            DataColumn(
                label: DataColums(icon: Icons.calendar_today, text: 'Ingreso')),
            DataColumn(
                label: DataColums(icon: Icons.date_range, text: 'Estimada')),
            DataColumn(
                label: DataColums(icon: Icons.location_city, text: 'Planta')),
            DataColumn(label: DataColums(icon: Icons.person, text: 'Cliente')),
            DataColumn(
                label: DataColums(icon: Icons.settings, text: 'Máquina')),
            DataColumn(
                label: DataColums(icon: Icons.engineering, text: 'Ingeniero')),
            DataColumn(
                label: DataColums(icon: Icons.comment, text: 'Observaciones')),
            DataColumn(label: DataColums(icon: Icons.flag, text: 'Estado')),
          ],
        ),
      ),
    );
  }
}

class CompletadosDataRow extends DataTableSource {
  final List<Proceso> procesos;
  CompletadosDataRow(this.procesos);

  @override
  DataRow? getRow(int index) {
    if (index >= procesos.length) return null;
    final proceso = procesos[index];

    final Color? rowColor = WidgetStateProperty.resolveWith<Color?>(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.blue.withOpacity(0.3);
        }
        return Colors.green.withOpacity(0.3);
      },
    ).resolve({});
    return DataRow(
      color: WidgetStateProperty.all(rowColor),
      cells: <DataCell>[
        DataCell(Text(proceso.ntroquel)),
        DataCell(Text('${proceso.fechaIngreso.toLocal()}'.split(' ')[0])),
        DataCell(Text('${proceso.fechaEstimada?.toLocal()}'.split(' ')[0])),
        DataCell(Text(proceso.planta)),
        DataCell(Text(proceso.cliente)),
        DataCell(Text(proceso.maquina)),
        DataCell(Text(proceso.ingeniero)),
        DataCell(Text(proceso.observaciones)),
        DataCell(Text(proceso.estado.name)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => procesos.length;

  @override
  int get selectedRowCount => 0;
}
