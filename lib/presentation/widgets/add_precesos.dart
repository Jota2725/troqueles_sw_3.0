import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/proceso.dart';
import '../providers/process_provider.dart';

class AddProcesos extends ConsumerStatefulWidget {
  final Proceso? proceso;
  const AddProcesos({super.key, this.proceso});

  @override
  ConsumerState<AddProcesos> createState() => _AddProcesosState();
}

class _AddProcesosState extends ConsumerState<AddProcesos> {
  String? selectedValue;
  String? selectedPlanta;
  String? selectedEstado;
  final controllers = <String, TextEditingController>{};
  DateTime? selectedFechaIngreso;
  DateTime? selectedFechaEstimada;

  final requiredFields = [
    'Troquel',
    'cliente',
    'Ingeniero',
  ];

  @override
  void initState() {
    super.initState();
    final fields = [
      'Troquel',
      'cliente',
      'Ingeniero',
      'estado',
      'observaciones'
    ];

    for (var field in fields) {
      controllers[field] = TextEditingController();
    }

    if (widget.proceso != null) {
      final proceso = widget.proceso!;
      controllers['Troquel']!.text = proceso.ntroquel;
      selectedFechaIngreso = proceso.fechaIngreso;
      selectedFechaEstimada = proceso.fechaEstimada;
      selectedPlanta = proceso.planta;
      controllers['cliente']!.text = proceso.cliente;
      selectedValue = proceso.maquina;
      controllers['Ingeniero']!.text =
          proceso.ingeniero; // Cambiado a 'Ingeniero'
      controllers['observaciones']!.text = proceso.observaciones; // Corregido
      selectedEstado = proceso.estado.toString();
    }
  }

  //  Métodos de mapeo para el manejo del enum Estado
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

  bool validateFields(BuildContext context) {
    // Validar campos de texto requeridos
    for (var field in requiredFields) {
      if (!controllers.containsKey(field) ||
          controllers[field]!.text.trim().isEmpty) {
        showError(context, 'El campo "${capitalize(field)}" es obligatorio.');
        return false;
      }
    }

    // Validar que se haya seleccionado una planta
    if (selectedPlanta == null || selectedPlanta!.trim().isEmpty) {
      showError(context, 'Debe seleccionar una planta.');
      return false;
    }

    // Validar que se haya seleccionado una máquina
    if (selectedValue == null || selectedValue!.trim().isEmpty) {
      showError(context, 'Debe seleccionar una máquina.');
      return false;
    }

    // Validar que se haya seleccionado un estado
    if (selectedEstado == null || selectedEstado!.trim().isEmpty) {
      showError(context, 'Debe seleccionar un estado.');
      return false;
    }

    // Validar fecha de ingreso
    if (selectedFechaIngreso == null) {
      showError(context, 'Debe seleccionar una fecha de ingreso.');
      return false;
    }

    // Validar fecha estimada
    if (selectedFechaEstimada == null) {
      showError(context, 'Debe seleccionar una fecha estimada.');
      return false;
    }

    // Validar que la fecha estimada sea posterior a la fecha de ingreso
    if (selectedFechaEstimada!.isBefore(selectedFechaIngreso!)) {
      showError(context,
          'La fecha estimada debe ser posterior a la fecha de ingreso.');
      return false;
    }

    return true; // Si pasa todas las validaciones, es válido
  }

  /// Muestra un mensaje de error con Fluent UI
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

  /// Capitaliza una cadena
  String capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  Widget buildTextField(String label, String key, {TextInputType? type}) {
    return TextBox(
      controller: controllers[key],
      placeholder: label,
      keyboardType: type,
    );
  }

  Widget buildRow(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: children
            .expand(
                (child) => [Expanded(child: child), const SizedBox(width: 20)])
            .toList()
          ..removeLast(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(widget.proceso == null
          ? 'Agregar troquel en proceso'
          : 'Editar troquel en proceso'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'A continuación, ingrese toda la información del troquel en proceso.'),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Numero de troquel',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                buildTextField('Troquel', 'Troquel'),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Fecha de ingreso:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                DatePicker(
                  selected: selectedFechaIngreso,
                  onChanged: (date) => setState(() {
                    selectedFechaIngreso = date;
                    print('Fecha convertida a DateTime: $selectedFechaIngreso');
                  }),
                  startDate: DateTime(2000),
                  endDate: DateTime(2100),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Fecha estimada:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                DatePicker(
                  selected: selectedFechaEstimada,
                  onChanged: (date) =>
                      setState(() => selectedFechaEstimada = date),
                  startDate: DateTime(2000),
                  endDate: DateTime(2100),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            buildRow([
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(' Ingrese la planta',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ComboBox<String>(
                    placeholder: const Text('Planta'),
                    value: selectedPlanta,
                    items: const [
                      ComboBoxItem(value: 'Cali', child: Text('Cali')),
                      ComboBoxItem(value: 'Medellin', child: Text('Medellin')),
                      ComboBoxItem(value: 'Bogota', child: Text('Bogota')),
                      ComboBoxItem(
                          value: 'Barranquilla', child: Text('Barranquilla')),
                    ],
                    onChanged: (value) =>
                        setState(() => selectedPlanta = value),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ingrese el cliente',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  buildTextField('Cliente', 'cliente'),
                ],
              ),
            ]),
            buildRow([
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ingrese la maquina',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ComboBox<String>(
                    placeholder: const Text('Máquina'),
                    value: selectedValue,
                    items: const [
                      ComboBoxItem(value: 'WA', child: Text('WARD')),
                      ComboBoxItem(value: 'TW', child: Text('HOLANDEZA')),
                      ComboBoxItem(value: 'FW', child: Text('FLEXPOWARD')),
                      ComboBoxItem(value: 'ML', child: Text('MINILINE')),
                      ComboBoxItem(value: 'DF', child: Text('DONFANG')),
                      ComboBoxItem(value: 'JS', child: Text('JS MACHINE')),
                    ],
                    onChanged: (value) => setState(() => selectedValue = value),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ingrese el ingeniero',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  buildTextField('Ingeniero', 'Ingeniero'),
                ],
              ),
            ]),
            buildRow([
              ComboBox<String>(
                placeholder: const Text('Estado'),
                value: selectedEstado,
                items: const [
                  ComboBoxItem(value: 'completado', child: Text('Completado')),
                  ComboBoxItem(value: 'enProceso', child: Text('En proceso')),
                  ComboBoxItem(value: 'suspendido', child: Text('Suspendido')),
                ],
                onChanged: (value) => setState(() => selectedEstado = value),
              ),
            ]),
            buildTextField('observaciones', 'observaciones'),
          ],
        ),
      ),
      actions: [
        Button(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFF141414))),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        Button(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFF0BAFFE))),
          child: Text(widget.proceso == null ? 'Agregar' : 'Guardar'),
          onPressed: () async {
            if (!validateFields(context)) return;

            final nuevoProceso = Proceso(
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

            final troquelNotifierInProceso =
                ref.read(troquelProviderInProceso.notifier);
            if (widget.proceso == null) {
              await troquelNotifierInProceso.addTroquelInProceso(nuevoProceso);
            } else {
              nuevoProceso.isarId = widget.proceso!.isarId;
              await troquelNotifierInProceso.updateTroquel(nuevoProceso);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
