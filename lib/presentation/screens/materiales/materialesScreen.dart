import 'package:flutter/material.dart';

import '../../../utils/input_decorations.dart';

class MaterialesScreen extends StatelessWidget {
  const MaterialesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              
              children: [
                const Text(
                  'Materiales',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,),
                ),
                Container(
                  color: Colors.red,
                  width: size.width,
                  
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.green,
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Center(
                                    child: Text(
                                      'Agregar material',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ...List.generate(
                                    6,
                                    (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: TextFormField(
                                        enabled: true,
                                        controller: TextEditingController(),
                                        decoration: InputDecorations
                                            .authInputDescoration(
                                          hintText:
                                              'Ingrese codigo del material',
                                          labelText:
                                              'Ingrese el codigo del material',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.blue,
                              padding: const EdgeInsets.all(10.0),
                              child: const Center(
                                child: Text(
                                  'Lista de materiales',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
