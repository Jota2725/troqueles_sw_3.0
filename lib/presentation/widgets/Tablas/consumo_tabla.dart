import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/presentation/providers/consumos_provider_table.dart'
    show consumoTablaProvider;

class ConsumosTabla extends ConsumerStatefulWidget {
  const ConsumosTabla({super.key});

  @override
  ConsumerState<ConsumosTabla> createState() => _ConsumosTablaState();
}

class _ConsumosTablaState extends ConsumerState<ConsumosTabla> {
  final _hCtrl = ScrollController();
  final _vCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    // Carga inicial de la tabla plana
    Future.microtask(
      () => ref.read(consumoTablaProvider.notifier).refresh(),
    );
  }

  @override
  void dispose() {
    _hCtrl.dispose();
    _vCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rows = ref.watch(consumoTablaProvider);

    // Asegurar un número válido de filas por página
    final int rowsPerPage =
        rows.isEmpty ? 1 : math.min(rows.length, 10); // 1..10

    // Tabla material dentro de scroll vertical + horizontal,
    // y con ancho mínimo para que no colapse.
    return Material(
      // Material es importante para PaginatedDataTable (tema/paddings)
      type: MaterialType.transparency,
      child: Scrollbar(
        controller: _vCtrl,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _vCtrl,
          scrollDirection: Axis.vertical,
          child: Scrollbar(
            controller: _hCtrl,
            thumbVisibility: true,
            notificationPredicate: (notif) =>
                notif.metrics.axis == Axis.horizontal,
            child: SingleChildScrollView(
              controller: _hCtrl,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: math.max(1200, MediaQuery.of(context).size.width - 48),
                child: PaginatedDataTable(
                  showFirstLastButtons: true,
                  columns: const [
                    DataColumn(label: Text('Planta')),
                    DataColumn(label: Text('Cliente')),
                    DataColumn(label: Text('N° Troquel')),
                    DataColumn(label: Text('Código')),
                    DataColumn(label: Text('Cantidad')),
                    DataColumn(label: Text('Conversión')),
                    DataColumn(label: Text('Unidad')),
                    DataColumn(label: Text('Descripción')),
                    DataColumn(label: Text('Tipo')),
                  ],
                  source: _ConsumoPlanoSource(rows),
                  rowsPerPage: rowsPerPage,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ConsumoPlanoSource extends DataTableSource {
  final List<Map<String, dynamic>> rows;
  _ConsumoPlanoSource(this.rows);

  @override
  DataRow? getRow(int index) {
    if (index < 0 || index >= rows.length) return null;
    final r = rows[index];
    String s(String k) => (r[k] ?? '').toString();

    return DataRow(cells: [
      DataCell(Text(s('planta'))),
      DataCell(Text(s('cliente'))),
      DataCell(Text(s('ntroquel'))),
      DataCell(Text(s('codigo'))),
      DataCell(Text(s('cantidad'))),
      DataCell(Text(s('conversion'))),
      DataCell(Text(s('unidad'))),
      DataCell(Text(s('descripcion'))),
      DataCell(Text(s('tipo'))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => rows.length;
  @override
  int get selectedRowCount => 0;
}
