import 'package:flutter/material.dart';

class PageAddTroquel extends StatelessWidget {
  final PageController pageController;

  const PageAddTroquel({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('¿Esta seguro?'),
                      actions: [
                        TextButton.icon(
                          label: Text('Salir'),
                            onPressed: () {
                              pageController.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            icon: Icon(Icons.exit_to_app))
                            , TextButton.icon(onPressed: (){}, label : Text('permanecer'), icon: Icon(Icons.health_and_safety_sharp),
                            
                            
                            
                            
                            
                      )
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Agregar a Bibliaco'),
      ),
      body: const Center(
        child: Text('AGREGAR A BIBLIACO'),
      ),
    );
  }
}
