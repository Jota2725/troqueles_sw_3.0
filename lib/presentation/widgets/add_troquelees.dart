import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/troquel.dart';
import '../../infrastructure/datasource/isar_datasource.dart';

class AddTroquelees extends StatefulWidget {
  final Troquel? troquel;
  const AddTroquelees({super.key, this.troquel});

  @override
  State<AddTroquelees> createState() => _AddTroqueleesState();
}

class _AddTroqueleesState extends State<AddTroquelees> {
  String? selectedValue;
  final ubicacionController = TextEditingController();
  final gicoController = TextEditingController();
  final clienteController = TextEditingController();
  final referenciaController = TextEditingController();
  final IsarDatasource isarDatasource = IsarDatasource();

  @override
  void initState() {
    super.initState();
    if (widget.troquel != null) {
      final troquel = widget.troquel!;
      ubicacionController.text = troquel.ubicacion.toString();
      gicoController.text = troquel.gico.toString();
      clienteController.text = troquel.cliente;
      referenciaController.text = troquel.referencia.toString();
      selectedValue = troquel.maquina;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.troquel == null ? 'Agregar troquel' : 'Editar troquel'),
      backgroundColor: FluentTheme.of(context).brightness == Brightness.light
          ? const Color(0xFFF5F5F5)
          : const Color(0xFF1E1E1E),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'A continuación ingrese toda la información del Troquel'),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: ubicacionController,
                    decoration: const InputDecoration(
                      labelText: 'Ingresa la ubicación',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: gicoController,
                    decoration: const InputDecoration(
                      labelText: 'Ingresa el GICO',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: clienteController,
              decoration: const InputDecoration(
                labelText: 'Ingresa el cliente',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: referenciaController,
              decoration: const InputDecoration(
                labelText: 'Ingresa el número CAD',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ComboBox<String>(
              placeholder: Text(
                selectedValue ?? 'Máquina',
                style: FluentTheme.of(context).typography.body,
              ),
              value: selectedValue,
              items: const [
                ComboBoxItem(value: 'WA', child: Text('WARD')),
                ComboBoxItem(value: 'TW', child: Text('HOLANDEZA')),
                ComboBoxItem(value: 'FW', child: Text('FLEXO WARD')),
                ComboBoxItem(value: 'ML', child: Text('MINI LINE')),
                ComboBoxItem(value: 'DF', child: Text('DON FANG')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1E1E),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Color(0xFFF5F5F5)),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0BAFFE),
                ),
                onPressed: () async {
                  if (ubicacionController.text.isEmpty ||
                      gicoController.text.isEmpty ||
                      clienteController.text.isEmpty ||
                      referenciaController.text.isEmpty ||
                      selectedValue == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Por favor, completa todos los campos requeridos.'),
                      ),
                    );
                    return;
                  }

                  // Crear o actualizar el troquel
                  final nuevoTroquel = Troquel(
                    ubicacion: int.parse(ubicacionController.text),
                    gico: int.parse(gicoController.text),
                    cliente: clienteController.text,
                    referencia: int.parse(referenciaController.text),
                    maquina: selectedValue!,
                  );

                  if (widget.troquel == null) {
                    // Agregar nuevo troquel
                    await isarDatasource.saveTroqueles([nuevoTroquel]);
                  } else {
                    // Actualizar troquel existente
                    nuevoTroquel.isarId = widget.troquel!.isarId;
                    await isarDatasource.updateTroquel(nuevoTroquel);
                  }

                  Navigator.of(context).pop();
                },
                child: Text(
                  widget.troquel == null ? 'Agregar' : 'Guardar',
                  style: const TextStyle(color: Color(0xFFF5F5F5)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
