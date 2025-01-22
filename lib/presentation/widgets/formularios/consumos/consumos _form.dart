import 'package:flutter/material.dart';
import 'package:troqueles_sw/domain/entities/materiales.dart';

import '../../../../utils/input_decorations.dart';
import '../../forms/Bibliaco/texfields_widgtes.dart';
import '../../search/search_materials.dart';

class ConsumosForm extends StatelessWidget {
  const ConsumosForm(
      {super.key,
      
      this.selectedMaterial,
      required this.cliente,
      required this.tipoTrabajo});

  final String cliente;
  final String tipoTrabajo;
  
  final Materiales? selectedMaterial;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    final TextEditingController cantidadController = TextEditingController();
    return Form(
      key: keyForm,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size * 0.5,
          child: Column(
            children: [
              CustomTextField(
                label: 'Cliente',
                value: cliente,
                enabled: false,
              ),
              CustomTextField(
                label: 'Cliente',
                value: tipoTrabajo,
                enabled: false,
              ),
              const SearchMaterials(),

              const SizedBox(height: 10,),

              CustomTextField(
                label: 'Descripción',
                value: selectedMaterial?.descripcion ?? 'Sin descripción',
                enabled: false,
              ),
              CustomTextField(
                label: 'Tipo',
                value: selectedMaterial?.tipo.name ?? 'Sin tipo',
                enabled: false,
              ),
              CustomTextField(
                label: 'Conversión',
                value:
                    selectedMaterial?.conversion.toString() ?? 'Sin conversión',
                enabled: false,
              ),
              TextFormField(
                controller: cantidadController,
                decoration: InputDecorations.authInputDescoration(
                  hintText: 'Cantidad',
                  labelText: 'Cantidad',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese una cantidad';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Ingrese un número válido';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
