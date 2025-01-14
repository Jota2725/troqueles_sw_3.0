import 'package:fluent_ui/fluent_ui.dart';
import '../controllers/procesos_form.dart';

class ProcesoFields extends StatefulWidget {
  final ProcesoFormController controller;

  const ProcesoFields({super.key, required this.controller});

  @override
  State<ProcesoFields> createState() => _ProcesoFieldsState();
}

class _ProcesoFieldsState extends State<ProcesoFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Campo de texto para "Número de Troquel"
        buildTextField('Número de troquel', 'Troquel'),
        const SizedBox(height: 20),
        // Fecha de ingreso
        buildDatePicker(
          label: 'Fecha de ingreso',
          selectedDate: widget.controller.selectedFechaIngreso,
          onDateChanged: (date) {
            setState(() {
              widget.controller.selectedFechaIngreso = date;
            });
          },
        ),
        const SizedBox(height: 20),
        // Fecha estimada
        buildDatePicker(
          label: 'Fecha estimada',
          selectedDate: widget.controller.selectedFechaEstimada,
          onDateChanged: (date) {
            setState(() {
              widget.controller.selectedFechaEstimada = date;
            });
          },
        ),
        const SizedBox(height: 20),
        // Planta (ComboBox)

        buildRow([
          buildComboBox(
            label: 'Planta',
            selectedValue: widget.controller.selectedPlanta,
            items: const ['Cali', 'Bogota', 'Medellin', 'Barranquilla'],
            onChanged: (value) {
              setState(() {
                widget.controller.selectedPlanta = value;
              });
            },
          ),
          
          buildTextField('Cliente', 'cliente'),
        ]),

        buildRow([
          buildComboBox(
              label: 'Maquina',
              selectedValue: widget.controller.selectedValue,
              items: const ['WA', 'TW', 'FW', 'ML', 'DF', 'JS'],
              onChanged: (value) {
                setState(() {
                  widget.controller.selectedValue = value;
                });
              }),
          buildTextField('Ingeniero', 'Ingeniero')
        ]),

        // Estado (ComboBox)
        buildComboBox(
          label: 'Estado',
          selectedValue: widget.controller.selectedEstado,
          items: const ['completado', 'enProceso', 'suspendido'],
          onChanged: (value) {
            setState(() {
              widget.controller.selectedEstado = value;
            });
          },
        ),
        const SizedBox(height: 10),
        // Campo de texto para "Cliente"
        buildTextField('Observaciones','observaciones'),
      ],
    );
  }

  Widget buildTextField(
    String label,
    String key,
  ) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextBox(
          controller: widget.controller.controllers[key],
          placeholder: label,
        ),
      ],
    );
  }

  Widget buildDatePicker({
    required String label,
    required DateTime? selectedDate,
    required ValueChanged<DateTime> onDateChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        DatePicker(
          selected: selectedDate,
          onChanged: onDateChanged,
          startDate: DateTime(2000),
          endDate: DateTime(2100),
        ),
      ],
    );
  }

  Widget buildComboBox({
  required String label,
  required String? selectedValue,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(
        width: double.infinity, // Ocupa todo el ancho disponible
        child: ComboBox<String>(
          placeholder: Text(label),
          value: selectedValue,
          items: items
              .map(
                (item) => ComboBoxItem(
                  value: item,
                  child: Text(item),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    ],
  );
}

  Widget buildRow(List<Widget> children) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
          .expand((child) => [Expanded(child: child),const SizedBox(width: 20) ]) // Asegura que cada widget se expanda
          .toList(),
    ),
  );
}
}
