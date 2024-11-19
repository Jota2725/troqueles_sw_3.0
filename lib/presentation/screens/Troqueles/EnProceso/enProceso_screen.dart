import 'package:flutter/material.dart';
import '../../../../domain/entities/proceso.dart';
import '../../../widgets/in_process_table.dart';

class EnprocesoScreen extends StatefulWidget {
  const EnprocesoScreen({super.key});

  @override
  _EnProsecoState createState() => _EnProsecoState();
}

class _EnProsecoState extends State<EnprocesoScreen> {
  final PageController _controller = PageController();
  final List<Proceso> _procesosCompletados = []; // Lista para guardar procesos completados
  final List<Proceso> _procesosBibliaco = []; // Lista para guardar procesos específicos

  final List<Proceso> procesosEjemplo = [
    Proceso(
      Tipo.nuevo,
      ntroquel: 'T001',
      fechaIngreso: DateTime.now(),
      fechaEstimada: DateTime.now().add(const Duration(days: 7)),
      planta: 'Ciudad A',
      cliente: 'Cliente 1',
      maquina: 'Máquina X',
      ingeniero: 'Ingeniero A',
      observaciones: 'Sin observaciones',
      estado: Estado.enProceso,
    ),
    Proceso(
      Tipo.reparacion,
      ntroquel: 'T002',
      fechaIngreso: DateTime.now().subtract(const Duration(days: 2)),
      fechaEstimada: DateTime.now().add(const Duration(days: 10)),
      planta: 'Ciudad B',
      cliente: 'Cliente 2',
      maquina: 'Máquina Y',
      ingeniero: 'Ingeniero B',
      observaciones: 'Pendiente de revisión',
      estado: Estado.suspendido,
    ),
    Proceso(
      Tipo.reparacion,
      ntroquel: 'T003',
      fechaIngreso: DateTime.now().subtract(const Duration(days: 2)),
      fechaEstimada: DateTime.now().add(const Duration(days: 10)),
      planta: 'Cali',
      cliente: 'Cliente 3',
      maquina: 'Máquina Z',
      ingeniero: 'Ingeniero C',
      observaciones: 'Urgente',
      estado: Estado.completado,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Función para validar y manejar los procesos completados
  void _handleNextPage() {
    final completados = procesosEjemplo.where((proceso) =>
        proceso.planta == 'Cali' && proceso.estado == Estado.completado);

    setState(() {
      // Agregar los procesos completados a la lista correspondiente
      _procesosCompletados.addAll(completados);

      // Agregar a la lista de Bibliaco si es necesario
      for (var proceso in completados) {
        if (!_procesosBibliaco.contains(proceso)) {
          _procesosBibliaco.add(proceso);
        }
      }
    });

    // Navegar a la siguiente página
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Función para manejar el cambio de estado de un proceso
  void _onEstadoChanged(Proceso proceso, Estado nuevoEstado) {
    setState(() {
      proceso.estado = nuevoEstado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TROQUELES EN PROCESO'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                ProcesoTable(
                  procesos: procesosEjemplo,
                 
                ),
                const Center(
                  child: Text(
                    'Agregar Troquel Bibliaco',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const Center(
                  child: Text(
                    'Consumos',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const Center(
                  child: Text(
                    'Tiempos',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('Anterior'),
              ),
              ElevatedButton(
                onPressed: _handleNextPage, // Llama a la función de manejo
                child: const Text('Siguiente'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
