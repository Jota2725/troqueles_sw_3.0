import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
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
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _horizontalScrollController,
      thumbVisibility: true,
      trackVisibility: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _horizontalScrollController,
        child: SizedBox(
          width: 1600, // Asegura que todo el contenido se vea
          child: Material(
            child: PaginatedDataTable(
              showEmptyRows: false,
              showFirstLastButtons: true,
              columns: const [
                DataColumn(label: Text('Copiar')),
                DataColumn(label: Text('Planta')),
                DataColumn(label: Text('Cliente')),
                DataColumn(label: Text('Ntroquel')),
                DataColumn(label: Text('Codigo')),
                DataColumn(label: Text('Cantidad')),
                DataColumn(label: Text('Conversion')),
                DataColumn(label: Text('Unidad')),
                DataColumn(label: Text('Descripcion')),
                DataColumn(label: Text('Tipo')),
                DataColumn(label: Text('Acciones')),
              ],
              source: _ConsumoDataSource(
                consumos: widget.consumo,
                context: context,
                consumoNotifier: widget.consumoNotifier,
                refresh: () => setState(() {}),
              ),
              rowsPerPage: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class _ConsumoDataSource extends DataTableSource {
  final List<Consumo> consumos;
  final BuildContext context;
  final ConsumoNotifier consumoNotifier;
  final VoidCallback refresh;

  _ConsumoDataSource({
    required this.consumos,
    required this.context,
    required this.consumoNotifier,
    required this.refresh,
  });

  @override
  DataRow getRow(int index) {
    final consumo = consumos[index];

    final codigos =
        consumo.materiales.map((m) => m.codigo.toString()).join(',');
    final conversiones =
        consumo.materiales.map((m) => m.conversion.toString()).join(',');
    final unidades = consumo.materiales.map((m) => m.unidad.name).join(',');
    final descripcionesCompletas =
        consumo.materiales.map((m) => m.descripcion).join(',');

// Esta variable sí la dejas para mostrar en la tabla visualmente
    final descripcionesVisibles = consumo.materiales
        .map((m) => _truncarDescripcion(m.descripcion, 10))
        .join(',');

    final tipos = consumo.materiales.map((m) => m.tipo.name).join(',');

    final rowData = [
      consumo.planta,
      consumo.cliente,
      consumo.nTroquel,
      codigos,
      consumo.cantidad.toString(),
      conversiones,
      unidades,
      descripcionesCompletas,
      tipos,
    ];

    return DataRow(cells: [
      DataCell(
        IconButton(
          icon: const Icon(Icons.copy, size: 18),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: rowData.join('\t')));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fila copiada al portapapeles')),
            );
          },
        ),
      ),
      DataCell(Text(rowData[0])),
      DataCell(Text(rowData[1])),
      DataCell(Text(rowData[2])),
      DataCell(Text(rowData[3])),
      DataCell(Text(rowData[4])),
      DataCell(Text(rowData[5])),
      DataCell(Text(rowData[6])),
      DataCell(Text(rowData[7])),
      DataCell(Text(rowData[8])),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () => _editarConsumo(consumo, index),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _confirmarEliminar(index),
          ),
        ],
      )),
    ]);
  }

  void _editarConsumo(Consumo consumo, int index) {
    final plantaCtrl = TextEditingController(text: consumo.planta);
    final clienteCtrl = TextEditingController(text: consumo.cliente);
    final cantidadCtrl =
        TextEditingController(text: consumo.cantidad.toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar consumo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: plantaCtrl,
                decoration: const InputDecoration(labelText: 'Planta')),
            TextField(
                controller: clienteCtrl,
                decoration: const InputDecoration(labelText: 'Cliente')),
            TextField(
              controller: cantidadCtrl,
              decoration: const InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text('Guardar'),
            onPressed: () {
              final updated = Consumo(
                planta: plantaCtrl.text,
                cliente: clienteCtrl.text,
                nTroquel: consumo.nTroquel,
                tipo: consumo.tipo,
                cantidad: int.tryParse(cantidadCtrl.text) ?? consumo.cantidad,
              );
              updated.materiales.addAll(consumo.materiales);

              consumoNotifier.updateConsumo(index, updated);
              refresh();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Consumo actualizado')),
              );
            },
          ),
        ],
      ),
    );
  }

  void _confirmarEliminar(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text(
            '¿Deseas eliminar este consumo? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
            onPressed: () {
              consumoNotifier.removeConsumo(index);
              refresh();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Consumo eliminado')),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  int get rowCount => consumos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

String _truncarDescripcion(String descripcion, int maxChars) {
  if (descripcion.length <= maxChars) return descripcion;
  return '${descripcion.substring(0, maxChars)}...';
}
