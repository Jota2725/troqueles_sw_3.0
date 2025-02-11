import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/tiempos.dart';
import 'package:troqueles_sw/presentation/providers/timepos_provider.dart';

class TiemposTabla extends ConsumerWidget {
  const TiemposTabla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tiemposNotifier = ref.watch(timeProvider.notifier);
    final tiempos = ref.watch(timeProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          TablaTiempos(tiempos: tiempos, tiemposNotifier: tiemposNotifier)
        ],
      ),
    );
  }
}

class TablaTiempos extends StatefulWidget {
  final List<Tiempos> tiempos;
  final TiemposNotifier tiemposNotifier;
  const TablaTiempos(
      {super.key, required this.tiempos, required this.tiemposNotifier});
  @override
  State<TablaTiempos> createState() => _TablaTiemposState();
}

class _TablaTiemposState extends State<TablaTiempos> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        child: PaginatedDataTable(
            showEmptyRows: false,
            showFirstLastButtons: true
            ,
          columns: const [
            DataColumn(label: Text('Fecha')),
            DataColumn(label: Text('Numero Troquel')),
            DataColumn(label: Text('Actividad')),
            DataColumn(label: Text('Operario')),
            DataColumn(label: Text('Tiempo')),
            DataColumn(label: Text('Editar/Borrar'))
          ],
          source: _TimposDataSource(
              tiempos: widget.tiempos,
              context: context,
              troquelNotifier: widget.tiemposNotifier),
          rowsPerPage: 15,
        ),
      ),
    );
  }
}

class _TimposDataSource extends DataTableSource {
  final List<Tiempos> tiempos;
  final BuildContext context;
  final TiemposNotifier troquelNotifier;

  _TimposDataSource(
      {required this.tiempos,
      required this.context,
      required this.troquelNotifier});

  @override
  DataRow getRow(int index) {
    final tiempo = tiempos[index];
    return DataRow(cells: [
      DataCell(Text(tiempo.fecha)),
      DataCell(Text(tiempo.ntroquel)),
      DataCell(Text(tiempo.actividad.name)),
      DataCell(Text(tiempo.operarios ?? 'no hay operario')),
      DataCell(Text('${tiempo.tiempo}')),
      DataCell(Row(
        children: [
          IconButton(
            tooltip: 'Editar Troquel',
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            tooltip: 'Eliminar Troquel',
            onPressed: () {},
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tiempos.length;

  @override
  int get selectedRowCount => 0;
}
