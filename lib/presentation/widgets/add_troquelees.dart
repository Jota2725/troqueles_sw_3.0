import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class AddTroquelees extends StatelessWidget {
  const AddTroquelees({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
     
     
     
      title: const Text('Agregar un nuevo troquel a la lista'),
       backgroundColor: FluentTheme.of(context).brightness == Brightness.light  ? 
            Color(0xFFF5F5F5)
            : const Color(0xFF1E1E1E), // Color de fondo según el tema
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Ingresa la ubicacion'),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Ingresa el gico'),
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar')),

            ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Agregar'))
      ],
    );
  }
}
