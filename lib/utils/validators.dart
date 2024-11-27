import 'package:fluent_ui/fluent_ui.dart';

bool validateFields(
  BuildContext context,
  List<String> requiredFields,
  Map<String, TextEditingController> controllers,
  DateTime? selectedFechaIngreso,
  DateTime? selectedFechaEstimada,
  String? selectedPlanta,
  String? selectedValue,
  String? selectedEstado,
) {
  for (var field in requiredFields) {
    if (!controllers.containsKey(field) || controllers[field]!.text.trim().isEmpty) {
      showError(context, 'El campo "$field" es obligatorio.');
      return false;
    }
  }

  if (selectedPlanta == null || selectedPlanta.trim().isEmpty) {
    showError(context, 'Debe seleccionar una planta.');
    return false;
  }

  if (selectedValue == null || selectedValue.trim().isEmpty) {
    showError(context, 'Debe seleccionar una máquina.');
    return false;
  }

  if (selectedEstado == null || selectedEstado.trim().isEmpty) {
    showError(context, 'Debe seleccionar un estado.');
    return false;
  }

  if (selectedFechaIngreso == null) {
    showError(context, 'Debe seleccionar una fecha de ingreso.');
    return false;
  }

  if (selectedFechaEstimada == null) {
    showError(context, 'Debe seleccionar una fecha estimada.');
    return false;
  }

  if (selectedFechaEstimada.isBefore(selectedFechaIngreso)) {
    showError(context, 'La fecha estimada debe ser posterior a la fecha de ingreso.');
    return false;
  }

  return true;
}

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
