import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';
import 'package:troqueles_sw/presentation/providers/materials_provider.dart';
import '../../../domain/entities/materiales.dart';
import '../../../domain/entities/operario.dart';
import '../../providers/operario_provider.dart';
import '../../providers/process_provider.dart';
import '../../widgets/formularios/tiempos/form_tiempos.dart';
import '../../widgets/scaled_text.dart'; // << para aplicar ScaledText
import '../Troqueles/consumos/consumos_page.dart';

class ConsumosAndTimes extends ConsumerWidget {
  const ConsumosAndTimes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProceso = ref.watch(selectedProcesoProvider);
    final procesos = ref.watch(troquelProviderInProceso);

    return Column(
      children: [
        _TablaEnProceso(procesos: procesos),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: selectedProceso != null
                    ? ConsumosPage(
                        planta: selectedProceso.planta,
                        cliente: selectedProceso.cliente,
                        ntroquel: selectedProceso.ntroquel,
                        tipoTrabajo: selectedProceso.maquina,
                      )
                    : const Center(
                        child: ScaledText(
                          'Seleccione un proceso para mostrar los detalles.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: FormTiempos(ntroquel: selectedProceso?.ntroquel ?? ''),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _TablaEnProceso extends ConsumerStatefulWidget {
  const _TablaEnProceso({
    required this.procesos,
    super.key,
  });

  final List<Proceso> procesos;

  @override
  ConsumerState<_TablaEnProceso> createState() => _TablaEnProcesoState();
}

class _TablaEnProcesoState extends ConsumerState<_TablaEnProceso> {
  Proceso? selectedProceso;
  late Future<List<Proceso>> futureProceso;
  late Future<List<Operario>> futureTiempo;
  late Future<List<Materiales>> futureMateriales;

  @override
  void initState() {
    super.initState();
    futureProceso = _cargarDatosProceso();
    futureTiempo = _cargarDatosOperario();
    futureMateriales = _cargarDatosMateriales();
  }

  Future<List<Proceso>> _cargarDatosProceso() async {
    final procesoNotifier = ref.read(troquelProviderInProceso.notifier);
    await procesoNotifier.getAllTroquelesInProcess();
    return procesoNotifier.state;
  }

  Future<List<Operario>> _cargarDatosOperario() async {
    final operarioNotifier = ref.read(operarioProvider.notifier);
    await operarioNotifier.loadOperario();
    return operarioNotifier.state;
  }

  Future<List<Materiales>> _cargarDatosMateriales() async {
    final materialesNotifier = ref.read(materialProvider.notifier);
    await materialesNotifier.loadMateriales();
    return materialesNotifier.state;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Material(
        child: SingleChildScrollView(
          child: DataTable(
            columnSpacing: 15,
            horizontalMargin: 5,
            dividerThickness: 1,
            sortColumnIndex: 0,
            sortAscending: true,
            columns: const <DataColumn>[
              DataColumn(label: ScaledText('Troquel')),
              DataColumn(label: ScaledText('Ingreso')),
              DataColumn(label: ScaledText('Estimada')),
              DataColumn(label: ScaledText('Planta')),
              DataColumn(label: ScaledText('Cliente')),
              DataColumn(label: ScaledText('Máquina')),
              DataColumn(label: ScaledText('Ingeniero')),
            ],
            rows: widget.procesos.map<DataRow>((proceso) {
              final rowColor = proceso.estado == Estado.enProceso
                  ? Colors.yellow.withOpacity(0.3)
                  : proceso.estado == Estado.suspendido
                      ? Colors.red.withOpacity(0.3)
                      : Colors.green.withOpacity(0.3);

              return DataRow(
                selected: selectedProceso == proceso,
                onSelectChanged: (isSelected) {
                  setState(() {
                    selectedProceso = isSelected == true ? proceso : null;
                  });
                  if (isSelected == true) {
                    ref.read(selectedProcesoProvider.notifier).state = proceso;
                  }
                },
                color: WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.blue.withOpacity(0.3);
                  }
                  return rowColor;
                }),
                cells: <DataCell>[
                  DataCell(ScaledText(proceso.ntroquel)),
                  DataCell(ScaledText(
                      '${proceso.fechaIngreso.toLocal()}'.split(' ')[0])),
                  DataCell(ScaledText(
                      '${proceso.fechaEstimada?.toLocal()}'.split(' ')[0])),
                  DataCell(ScaledText(proceso.planta)),
                  DataCell(ScaledText(proceso.cliente)),
                  DataCell(ScaledText(proceso.maquina)),
                  DataCell(ScaledText(proceso.ingeniero)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
