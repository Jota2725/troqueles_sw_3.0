import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/consumo.dart';

import '../../providers/consumos_provider.dart';

class ConsumosTabla extends ConsumerWidget {
  const ConsumosTabla({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consumosNotifier = ref.watch(consumoProvider.notifier);
    final consumos = ref.watch(consumoProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          TablaConsumo(consumo: consumos, consumoNotifier: consumosNotifier)
        ],
      ),
    );
  }
}

class TablaConsumo extends StatefulWidget {
  final List<Consumo> consumo;
  final ConsumoNotifier consumoNotifier;
  const TablaConsumo({
    super.key,
    required this.consumo,
    required this.consumoNotifier,
  });

  @override
  State<TablaConsumo> createState() => _TablaConsumoState();
}

class _TablaConsumoState extends State<TablaConsumo> {
  // Índice de la fila expandida

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        child: PaginatedDataTable(
          showEmptyRows: false,
          showFirstLastButtons: true,
          columns: const [
            DataColumn(label: Text('Cliente')),
            DataColumn(label: Text('Ntroquel')),
            DataColumn(label: Text('Codigo')),
            DataColumn(label: Text('Cantidad')),
            DataColumn(label: Text('Conversion')),
            DataColumn(label: Text('Unidad')),
            DataColumn(label: Text('Descripcion')),
            DataColumn(label: Text('Tipo')),
          ],
          source: _ConsumoDataSource(
            consumos: widget.consumo,
            context: context,
            consumoNotifier: widget.consumoNotifier,
          ),
          rowsPerPage: 15,
        ),
      ),
    );
  }
}

class _ConsumoDataSource extends DataTableSource {
  final List<Consumo> consumos;
  final BuildContext context;
  final ConsumoNotifier consumoNotifier;

  _ConsumoDataSource({
    required this.consumos,
    required this.context,
    required this.consumoNotifier,
  });

// consumo.materiales.map((material) {

  @override
  DataRow getRow(int index) {
    final consumo = consumos[index];
    return DataRow(cells: [
      DataCell(Text(consumo.cliente)),
      DataCell(Text(consumo.nTroquel)),
      DataCell(Text(consumo.materiales
          .map((material) => material.codigo.toString())
          .join(','))),
      DataCell(Text(consumo.cantidad.toString())),
      DataCell(Text(
          consumo.materiales.map((material) => material.conversion).join(','))),
      DataCell(Text(consumo.materiales
          .map((material) => material.unidad.name)
          .join(','))),
      DataCell(Text(consumo.materiales
          .map((material) => material.descripcion)
          .join(','))),
      DataCell(Text(
          consumo.materiales.map((material) => material.tipo.name).join(','))),
    ]);
  }

  @override
  int get rowCount => consumos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
