import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/materiales.dart';
import '../../../../utils/input_decorations.dart';
import '../../../providers/materials_provider.dart';
import '../../scaled_text.dart';

class EditarMaterialDialog extends ConsumerStatefulWidget {
  final Materiales material;

  const EditarMaterialDialog({super.key, required this.material});

  @override
  ConsumerState<EditarMaterialDialog> createState() =>
      _EditarMaterialDialogState();
}

class _EditarMaterialDialogState extends ConsumerState<EditarMaterialDialog> {
  late TextEditingController codigoController;
  late TextEditingController descripcionController;
  late TextEditingController conversionController;
  late Unidad unidadSeleccionada;
  late Tipo tipoSeleccionado;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    codigoController =
        TextEditingController(text: widget.material.codigo.toString());
    descripcionController =
        TextEditingController(text: widget.material.descripcion);
    conversionController =
        TextEditingController(text: widget.material.conversion.toString());
    unidadSeleccionada = widget.material.unidad;
    tipoSeleccionado = widget.material.tipo;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const ScaledText("Editar material"),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: codigoController,
                decoration: InputDecorations.authInputDescoration(
                  hintText: 'Código',
                  labelText: 'Código del material',
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese el código' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<Unidad>(
                value: unidadSeleccionada,
                items: Unidad.values
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => unidadSeleccionada = value);
                  }
                },
                decoration: InputDecorations.authInputDescoration(
                  hintText: 'Seleccione unidad',
                  labelText: 'Unidad',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descripcionController,
                decoration: InputDecorations.authInputDescoration(
                  hintText: 'Descripción',
                  labelText: 'Descripción del material',
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese la descripción'
                    : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<Tipo>(
                value: tipoSeleccionado,
                items: Tipo.values
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => tipoSeleccionado = value);
                  }
                },
                decoration: InputDecorations.authInputDescoration(
                  hintText: 'Seleccione tipo',
                  labelText: 'Tipo de material',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: conversionController,
                decoration: InputDecorations.authInputDescoration(
                  hintText: 'Conversión',
                  labelText: 'Conversión',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Ingrese la conversión';
                  if (double.tryParse(value) == null)
                    return 'Conversión inválida';
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
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              final actualizado = Materiales(
                codigo: int.parse(codigoController.text),
                unidad: unidadSeleccionada,
                descripcion: descripcionController.text,
                tipo: tipoSeleccionado,
                conversion: double.parse(conversionController.text),
              )..isarId = widget.material.isarId;

              await ref
                  .read(materialProvider.notifier)
                  .addMateriales(actualizado);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: ScaledText('Material actualizado correctamente.'),
                  backgroundColor: Colors.blue,
                ),
              );
            }
          },
          icon: const Icon(Icons.save),
          label: const ScaledText("Guardar cambios"),
        ),
      ],
    );
  }
}
