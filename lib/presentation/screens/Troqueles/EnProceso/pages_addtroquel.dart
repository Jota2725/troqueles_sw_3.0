import 'package:flutter/material.dart';
import '../../../../utils/input_decorations.dart';

class PageAddTroquel extends StatefulWidget {
  final PageController pageController;
  final String numeroTroquel;
  final String cliente;
  final String maquina;

  const PageAddTroquel({
    super.key,
    required this.pageController,
    required this.numeroTroquel,
    required this.cliente,
    required this.maquina,
  });

  @override
  State<PageAddTroquel> createState() => _PageAddTroquelState();
}

class _PageAddTroquelState extends State<PageAddTroquel> {
  late final TextEditingController numeroTroquelController;
  late final TextEditingController clienteController;
  late final TextEditingController maquinaController;
  final TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey();

  @override
  void initState() {
    super.initState();
    numeroTroquelController = TextEditingController(text: widget.numeroTroquel);
    clienteController = TextEditingController(text: widget.cliente);
    maquinaController = TextEditingController(text: widget.maquina);
  }

  @override
  void dispose() {
    numeroTroquelController.dispose();
    clienteController.dispose();
    maquinaController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
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
        title: const Text('Agregar a Bibliaco'),
      ),
      body: Container(
        width: double.infinity,
        height: double.maxFinite,
        child: Column(
          children: [
            const Text('A continuación ingrese toda la información del troquel nuevo'),
            const SizedBox(height: 10),
              Form(
              key: keyForm,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size * 0.5,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: numeroTroquelController,
                        enabled: false,
                        decoration: InputDecorations.authInputDescoration(
                          hintText: '3678',
                          labelText: 'Numero de troquel',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: clienteController,
                        enabled: false,
                        decoration: InputDecorations.authInputDescoration(
                          hintText: 'Plasticos Rimax',
                          labelText: 'Cliente'
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: textEditingController,
                        decoration: InputDecorations.authInputDescoration(
                          hintText: '12354357',
                          labelText: 'Referencia CAD',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: maquinaController,
                        enabled: false,
                      
                        decoration: InputDecorations.authInputDescoration(
                          hintText: 'Holandeza',
                          labelText: 'Maquina'
                    
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: textEditingController,
                              decoration: InputDecorations.authInputDescoration(
                                hintText: '17',
                                labelText: 'Largo',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: textEditingController,
                              decoration: InputDecorations.authInputDescoration(
                                hintText: '20',
                                labelText: 'Ancho',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: textEditingController,
                              decoration: InputDecorations.authInputDescoration(
                                hintText: '30',
                                labelText: 'Alto',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: textEditingController,
                        decoration: InputDecorations.authInputDescoration(
                          hintText: 'Peso',
                          labelText: 'Peso',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: textEditingController,
                        decoration: InputDecorations.authInputDescoration(
                          hintText: 'Material',
                          labelText: 'Material',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: textEditingController,
                        decoration: InputDecorations.authInputDescoration(
                          hintText: 'Comentarios',
                          labelText: 'Comentarios',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
