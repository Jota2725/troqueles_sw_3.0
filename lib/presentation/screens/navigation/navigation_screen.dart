import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:troqueles_sw/presentation/screens/Troqueles/bibliaco/bibliaco_pages.dart';
import 'package:troqueles_sw/presentation/screens/consumos_tiempos/consumos_and_times.dart';
import 'package:troqueles_sw/presentation/screens/home_screen.dart';
import 'package:troqueles_sw/presentation/screens/tiempos/tiempos_screen.dart';
import '../../../infrastructure/datasource/isar_datasource.dart';
import '../../widgets/Tablas/completados_tabla.dart';
import '../Troqueles/EnProceso/troquel_view_pages.dart';
import '../consumos/consumos_screen.dart';
import '../materiales/materiales_screen.dart';

class NavigationScreen extends StatefulWidget {
  static const name = 'Navegation_Screen';
  const NavigationScreen({super.key});
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return NavigationView(
      appBar: const NavigationAppBar(
          leading: Center(
              child: Image(
            image: AssetImage('assets/Smurfit_Westrock_(logo).png'),
          )),
          title: Center(
              child: Text(
            'SW TROQUELES 1.0 ',
            style: TextStyle(fontSize: 30),
          ))),
      pane: NavigationPane(
        size: NavigationPaneSize(openMaxWidth: size.width * 0.20),
        header: const Padding(
          padding: EdgeInsets.only(left: 20),
        ),
        items: [
          PaneItem(
            icon: const Icon(
              Icons.home,
            ),
            body: const HomeScreen(),
            title: const Text('Inicio'),
          ),
          PaneItemHeader(header: const Text('Troqueles')),
          PaneItemExpander(
              body: const Text('Bibliaco General'),
              title: const Text('Bibliaco'),
              icon: const Icon(Icons.book_rounded),
              items: [
                PaneItemHeader(header: const Text('Maquinas')),
                PaneItem(
                  icon: const Icon(Icons.factory),
                  body: const BibliacoPages(
                    titulo: 'Troqueladora Ward',
                    hojaDeseada: 'WA',
                  ),
                  title: const Text('Ward'),
                ),
                PaneItem(
                  icon: const Icon(Icons.factory),
                  body: const BibliacoPages(
                      titulo: 'Troqueladora Flexo ward', hojaDeseada: 'FW'),
                  title: const Text('Flexo Ward'),
                ),
                PaneItem(
                  icon: const Icon(Icons.factory),
                  body: const BibliacoPages(
                      titulo: 'Holandeza', hojaDeseada: 'TW'),
                  title: const Text('Holandeza'),
                ),
                PaneItem(
                  icon: const Icon(Icons.factory),
                  body: const BibliacoPages(
                      titulo: 'JS Machine', hojaDeseada: 'JS'),
                  title: const Text('Js Machine'),
                ),
                PaneItem(
                  icon: const Icon(Icons.factory),
                  body: const BibliacoPages(
                      titulo: 'Mini Line', hojaDeseada: 'ML'),
                  title: const Text('Mini line'),
                ),
                PaneItem(
                  icon: const Icon(Icons.factory),
                  body:
                      const BibliacoPages(titulo: 'DonFang', hojaDeseada: 'DF'),
                  title: const Text('DongFang'),
                ),
              ]),
          PaneItem(
            icon: const Icon(Icons.autorenew),
            body: const TroquelViewPages(),
            title: const Text('Troqueles en proceso'),
          ),
          PaneItem(
            icon: const Icon(Icons.fact_check_outlined),
            body: const CompletadosTable(),
            title: const Text('Troqueles terminados'),
          ),
          PaneItem(
            icon: const Icon(Icons.delete_forever),
            body: const Text(''),
            title: const Text('Troqueles Obsoletos'),
          ),
          PaneItemHeader(header: const Text('Consumos  y materiales ')),
          PaneItem(
            icon: const Icon(Icons.document_scanner),
            body: const ConsumosAndTimes(),
            title: const Text('Consumos y tiempos'),
          ),
          PaneItem(
            icon: const Icon(Icons.document_scanner),
            body: const Text('General'),
            title: const Text('General'),
          ),
          PaneItem(
            icon: const Icon(Icons.access_time_outlined),
            body: const TiemposScreen(),
            title: const Text('Tiempos'),
          ),
          PaneItem(
            icon: const Icon(Icons.widgets),
            body: const MaterialesScreen(),
            title: const Text('Materiales'),
          ),
          PaneItem(
            icon: const Icon(Icons.inventory),
            body: const ConsumoScreen(),
            title: const Text('Consumos de material'),
          ),
          PaneItem(
            icon: const Icon(Icons.summarize),
            body: const Text('Resumen'),
            title: const Text('Resumen'),
          ),
          PaneItemHeader(header: const Text('Accesibilidad')),
          PaneItem(
            icon: const Icon(Icons.accessibility_new),
            body: const Text('Accesibilidad'),
            title: const Text('Accesibilidad'),
          ),
          PaneItem(
            icon: const Icon(Icons.settings),
            body: const Text('Ajustes'),
            title: const Text('Ajustes'),
          ),
          PaneItem(
              icon:
                  Icon(Icons.exit_to_app, color: Color.fromRGBO(255, 0, 0, 1)),
              title: const Text('Salir'),
              body: const Text(''),
              onTap: () {
                final isarDatasource = IsarDatasource();
                isarDatasource.closeDB;
                exit(0);
              })
        ],
        selected: _currentIndex,
        displayMode: PaneDisplayMode.auto,
        onChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
