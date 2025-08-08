import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/presentation/providers/general_provider.dart';
import 'package:troqueles_sw/domain/entities/general_info.dart';
import 'package:flutter/services.dart';

void copyToClipboard(List<GeneralInfo> data) {
  final buffer = StringBuffer();

  for (var row in data) {
    buffer.writeln('${row.planta}\t'
        '${row.cliente}\t'
        '${row.ntroquel}\t'
        '${row.totalDibCal.toStringAsFixed(2)}\t'
        '${row.totalEncEng.toStringAsFixed(2)}\t'
        '${row.totalTiempo.toStringAsFixed(2)}\t'
        '${row.totalCuchiEsc.toStringAsFixed(2)}');
  }

  Clipboard.setData(ClipboardData(text: buffer.toString()));
}

class _GeneralInfoDataSource extends DataTableSource {
  final List<GeneralInfo> rows;
  _GeneralInfoDataSource(this.rows);

  @override
  DataRow getRow(int index) {
    if (index >= rows.length) return const DataRow(cells: []);
    final row = rows[index];
    return DataRow(cells: [
      DataCell(Text(row.planta)),
      DataCell(Text(row.cliente)),
      DataCell(Text(row.ntroquel)),
      DataCell(Text(row.totalDibCal.toStringAsFixed(2))),
      DataCell(Text(row.totalEncEng.toStringAsFixed(2))),
      DataCell(Text(row.totalTiempo.toStringAsFixed(2))),
      DataCell(Text(row.totalCuchiEsc.toStringAsFixed(2))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => rows.length;

  @override
  int get selectedRowCount => 0;
}

class GeneralInfoScreen extends ConsumerWidget {
  const GeneralInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final generalInfoAsync = ref.watch(generalProvider);

    return generalInfoAsync.when(
      data: (rows) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Resumen General de Troqueles',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  FilledButton(
                    onPressed: () => copyToClipboard(rows),
                    child: const Text('Copiar'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PaginatedDataTable(
                columns: const [
                  DataColumn(label: Text('Planta')),
                  DataColumn(label: Text('Cliente')),
                  DataColumn(label: Text('N° Troquel')),
                  DataColumn(label: Text('Total Dib/Cal')),
                  DataColumn(label: Text('Total Enc/Eng')),
                  DataColumn(label: Text('Total Tiempo')),
                  DataColumn(label: Text('Total Cuchi/Esc')),
                ],
                source: _GeneralInfoDataSource(rows),
                rowsPerPage: 10,
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
