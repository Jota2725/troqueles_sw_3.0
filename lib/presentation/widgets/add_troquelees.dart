import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';
import '../providers/troqueles_provider.dart';

class AddTroquelees extends ConsumerStatefulWidget {
  final Troquel? troquel;
  const AddTroquelees({super.key, this.troquel});

  @override
  ConsumerState<AddTroquelees> createState() => _AddTroquelesState();
}

class _AddTroquelesState extends ConsumerState<AddTroquelees> {
  String? selectedValue;
  final controllers = <String, TextEditingController>{};
  final requiredFields = [ 'gico', 'cliente', 'referencia', 'clave', 'alto', 'ancho', 'largo', 'cabida', 'estilo'];

  @override
  void initState() {
    super.initState();
    final fields = [
      'ubicacion',
      'gico',
      'cliente',
      'referencia',
      'clave',
      'alto',
      'ancho',
      'largo',
      'cabida',
      'estilo',
      'descripcion'
    ];

    for (var field in fields) {
      controllers[field] = TextEditingController();
    }

    if (widget.troquel != null) {
      final troquel = widget.troquel!;
      controllers['ubicacion']!.text = troquel.ubicacion.toString();
      controllers['gico']!.text = troquel.gico.toString();
      controllers['cliente']!.text = troquel.cliente;
      controllers['referencia']!.text = troquel.referencia.toString();
      selectedValue = troquel.maquina;
      controllers['clave']!.text = troquel.clave ?? '' ;
      controllers['alto']!.text = troquel.alto.toString();
      controllers['ancho']!.text = troquel.ancho.toString();
      controllers['largo']!.text = troquel.largo.toString();
      controllers['cabida']!.text = troquel.cabida.toString();
      controllers['estilo']!.text = troquel.estilo ?? '';
      controllers['descripcion']!.text = troquel.descripcion ?? '';
    }
  }

  /// Valida si los campos requeridos están llenos
  bool validateFields(BuildContext context) {
    for (var field in requiredFields) {
      if (controllers[field]!.text.trim().isEmpty) {
        showError(context, 'El campo "${capitalize(field)}" es obligatorio.');
        return false;
      }
    }

    if (selectedValue == null || selectedValue!.isEmpty) {
      showError(context, 'El campo "Máquina" es obligatorio.');
      return false;
    }

    return true;
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
            .expand((child) => [Expanded(child: child), const SizedBox(width: 20)])
            .toList()
          ..removeLast(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(widget.troquel == null ? 'Agregar troquel' : 'Editar troquel'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('A continuación ingrese toda la información del Troquel'),
            const SizedBox(height: 20),
            buildRow([
              buildTextField('Ubicación', 'ubicacion', type: TextInputType.number),
              buildTextField('GICO', 'gico', type: TextInputType.number),
            ]),
            buildTextField('Cliente', 'cliente'),
            const SizedBox(height: 20),
            buildTextField('Número CAD', 'referencia', type: TextInputType.number),
            const SizedBox(height: 20),
            buildRow([
              ComboBox<String>(
                placeholder: const Text('máquina'),
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
              buildTextField('Clave', 'clave'),
            ]),
            buildRow([
              buildTextField('Largo', 'largo', type: TextInputType.number),
              buildTextField('Ancho', 'ancho', type: TextInputType.number),
              buildTextField('Alto', 'alto', type: TextInputType.number),
            ]),
            buildRow([
              buildTextField('Cabida', 'cabida', type: TextInputType.number),
              buildTextField('Estilo', 'estilo'),
            ]),
            buildTextField('Descripción', 'descripcion'),
          ],
        ),
      ),
      actions: [
        Button(
          style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xFF141414 ))),
          child: const Text('Cancelar',style:  TextStyle(color: Colors.white),),
          onPressed: () => Navigator.pop(context),
        ),
        Button(
          style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xFF0BAFFE ))),
          child: Text(widget.troquel == null ? 'Agregar' : 'Guardar'),
          onPressed: () async {
            if (!validateFields(context)) return;

            final nuevoTroquel = Troquel(
              ubicacion: controllers['ubicacion']!.text,
              gico: int.parse(controllers['gico']!.text),
              cliente: controllers['cliente']!.text,
              referencia: int.parse(controllers['referencia']!.text),
              maquina: selectedValue!,
              clave: controllers['clave']!.text,
              alto: int.parse(controllers['alto']!.text),
              ancho: int.parse(controllers['ancho']!.text),
              largo: int.parse(controllers['largo']!.text),
              cabida: int.parse(controllers['cabida']!.text),
              estilo: controllers['estilo']!.text,
              descripcion: controllers['descripcion']!.text,
            );

            final troquelNotifier = ref.read(troquelProvider.notifier);
            if (widget.troquel == null) {
              await troquelNotifier.addTroquel(nuevoTroquel);
            } else {
              nuevoTroquel.isarId = widget.troquel!.isarId;
              await troquelNotifier.updateTroquel(nuevoTroquel);
            }
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
