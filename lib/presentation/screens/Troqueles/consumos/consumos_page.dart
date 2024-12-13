import 'package:flutter/material.dart';


import '../../../../domain/entities/materiales.dart'; // Asegúrate de importar correctamente tus clases y dependencias.

class ConsumosPage extends StatefulWidget {
  const ConsumosPage({
    super.key,
    required this.ntroquel,
    required this.cliente,
    required this.tipoTrabajo,
    required this.pageController,
  });

  final PageController pageController;
  final String ntroquel;
  final String cliente;
  final String tipoTrabajo;

  @override
  State<ConsumosPage> createState() => _ConsumosPageState();
}

class _ConsumosPageState extends State<ConsumosPage> {
  // Simulamos la lista de materiales para este ejemplo.
  final List<Materiales> materiales = [
    Materiales(
      codigo: 1,
      unidad: Unidad.mts,
      descripcion: 'Madera tipo A',
      tipo: Tipo.maderas,
      cantidad: 10,
      conversion: 1.0,
    ),
    Materiales(
      codigo: 2,
      unidad: Unidad.rollo,
      descripcion: 'Cuchilla tipo B',
      tipo: Tipo.cuchillas,
      cantidad: 5,
      conversion: 0.5,
    ),
    Materiales(
      codigo: 3,
      unidad: Unidad.und,
      descripcion: 'Herramienta básica',
      tipo: Tipo.herramientas,
      cantidad: 15,
      conversion: 0.2,
    ),
  ];

  void _agregarMaterial(Tipo tipo) {
    // Lógica para agregar un material (puedes personalizarla).
    setState(() {
      materiales.add(Materiales(
        codigo: materiales.length + 1,
        unidad: Unidad.und,
        descripcion: 'Nuevo material de tipo ${tipo.name}',
        tipo: tipo,
        cantidad: 1,
        conversion: 1.0,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar consumos al troquel ${widget.ntroquel}'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('¿Está seguro?'),
                  actions: [
                    TextButton.icon(
                      label: const Text('Salir'),
                      onPressed: () {
                        widget.pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.exit_to_app),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      label: const Text('Permanecer'),
                      icon: const Icon(Icons.health_and_safety_sharp),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CLIENTE : ${widget.cliente}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text('TIPO DE TRABAJO : ${widget.tipoTrabajo}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: Tipo.values.length,
              itemBuilder: (context, index) {
                final tipo = Tipo.values[index];
                final materialesPorTipo = materiales
                    .where((material) => material.tipo == tipo)
                    .toList();

                return ExpansionTile(
                  
                  title: Text(tipo.name.toUpperCase()),
                  
                  subtitle: Text(
                      materialesPorTipo.isNotEmpty
                          ? 'Total: ${materialesPorTipo.length} materiales'
                          : 'No hay materiales en esta categoría'),
                  children: [
                    ...materialesPorTipo.map((material) {
                      return ListTile(
                        title: Text(material.descripcion),
                        subtitle: Text(
                            'Código: ${material.codigo}, Cantidad: ${material.cantidad}, Unidad: ${material.unidad.name}, Conversion: ${material.conversion} '),
                      );
                    }).toList(),
                    ListTile(
                      title: const Text('Agregar material'),
                      trailing: const Icon(Icons.add),
                      onTap: () => _agregarMaterial(tipo),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
