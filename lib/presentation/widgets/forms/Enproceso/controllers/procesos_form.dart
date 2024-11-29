import 'package:fluent_ui/fluent_ui.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';

class ProcesoFormController {
  final Proceso? initialProceso;

  String? selectedValue;
  String? selectedPlanta;
  String? selectedEstado;
  final controllers = <String, TextEditingController>{};
  DateTime? selectedFechaIngreso;
  DateTime? selectedFechaEstimada;

  final requiredFields = ['Troquel', 'cliente', 'Ingeniero'];

  ProcesoFormController(this.initialProceso) {
    final fields = ['Troquel', 'cliente', 'Ingeniero', 'estado', 'observaciones'];
    for (var field in fields) {
      controllers[field] = TextEditingController();
    }

    if (initialProceso != null) {
      controllers['Troquel']!.text = initialProceso!.ntroquel;
      selectedFechaIngreso = initialProceso!.fechaIngreso;
      selectedFechaEstimada = initialProceso!.fechaEstimada;
      selectedPlanta = initialProceso!.planta;
      controllers['cliente']!.text = initialProceso!.cliente;
      selectedValue = initialProceso!.maquina;
      controllers['Ingeniero']!.text = initialProceso!.ingeniero;
      controllers['observaciones']!.text = initialProceso!.observaciones;
      selectedEstado = estadoToString(initialProceso!.estado);
    }
  }

  Proceso buildProceso() {
    return Proceso(
      ntroquel: controllers['Troquel']!.text,
      fechaIngreso: selectedFechaIngreso!,
      fechaEstimada: selectedFechaEstimada!,
      planta: selectedPlanta!,
      cliente: controllers['cliente']!.text,
      maquina: selectedValue!,
      ingeniero: controllers['Ingeniero']!.text,
      observaciones: controllers['observaciones']?.text ?? '',
      estado: stringToEstado(selectedEstado!),
    );
  }

  bool validateFields(BuildContext context) {
    for (var field in requiredFields) {
      if (controllers[field]!.text.trim().isEmpty) {
        showError(context, 'El campo "${capitalize(field)}" es obligatorio.');
        return false;
      }
    }
    if (selectedPlanta == null || selectedValue == null || selectedEstado == null) {
      showError(context, 'Todos los campos deben estar completos.');
      return false;
    }
    if (selectedFechaIngreso == null || selectedFechaEstimada == null) {
      showError(context, 'Debe seleccionar las fechas correspondientes.');
      return false;
    }
    if (selectedFechaEstimada!.isBefore(selectedFechaIngreso!)) {
      showError(context,
          'La fecha estimada debe ser posterior a la fecha de ingreso.');
      return false;
    }
    return true;
  }

  String capitalize(String text) => text[0].toUpperCase() + text.substring(1);

  void showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          Button(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Estado stringToEstado(String value) {
    switch (value) {
      case 'completado':
        return Estado.completado;
      case 'enProceso':
        return Estado.enProceso;
      case 'suspendido':
        return Estado.suspendido;
      default:
        throw ArgumentError('Estado inválido: $value');
    }
  }

  String estadoToString(Estado estado) {
    switch (estado) {
      case Estado.completado:
        return 'completado';
      case Estado.enProceso:
        return 'enProceso';
      case Estado.suspendido:
        return 'suspendido';
      default:
        throw ArgumentError('Estado inválido: $estado');
    }
  }
}
