import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/materiales.dart';
import '../../../../utils/input_decorations.dart';
import '../../../providers/materials_provider.dart';
import '../../scaled_text.dart';

class MaterialFormDialog extends ConsumerStatefulWidget {
  const MaterialFormDialog({super.key});

  @override
  ConsumerState<MaterialFormDialog> createState() => _MaterialFormDialogState();
}

class _MaterialFormDialogState extends ConsumerState<MaterialFormDialog> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController conversionController = TextEditingController();
  Unidad? unidadSeleccionada;
  Tipo? tipoSeleccionado;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const ScaledText("Añadir material"),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: codigoController,
                decoration: InputDecorations.authInputDescoration(
                  hintText: 'Ingrese el código del material',
                  labelText: 'Código',
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese el código' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<Unidad>(
                items: Unidad.values
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChanged: (value) => unidadSeleccionada = value,
                decoration: InputDecorations.authInputDescoration(
                  hintText: 'Seleccione unidad',
                  labelText: 'Unidad',
                ),
                validator: (value) =>
                    value == null ? 'Seleccione una unidad' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descripcionController,
                decoration: InputDecorations.authInputDescoration(
                  hintText: 'Ingrese la descripción',
                  labelText: 'Descripción',
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese descripción'
                    : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<Tipo>(
                items: Tipo.values
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChanged: (value) => tipoSeleccionado = value,
                decoration: InputDecorations.authInputDescoration(
                  hintText: 'Seleccione tipo',
                  labelText: 'Tipo',
                ),
                validator: (value) =>
                    value == null ? 'Seleccione un tipo' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: conversionController,
                decoration: InputDecorations.authInputDescoration(
                  hintText: 'Ingrese la conversión',
                  labelText: 'Conversión',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Ingrese conversión';
                  final val = double.tryParse(value);
                  if (val == null) return 'Conversión inválida';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const ScaledText("Cancelar"),
        ),
        ElevatedButton.icon(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              final newMaterial = Materiales(
                codigo: int.parse(codigoController.text),
                tipo: tipoSeleccionado!,
                unidad: unidadSeleccionada!,
                descripcion: descripcionController.text,
                conversion: double.parse(conversionController.text),
              );

              ref.read(materialProvider.notifier).addMateriales(newMaterial);

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: ScaledText('Material guardado exitosamente.'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          icon: const Icon(Icons.save),
          label: const ScaledText("Guardar"),
        ),
      ],
    );
  }
}
