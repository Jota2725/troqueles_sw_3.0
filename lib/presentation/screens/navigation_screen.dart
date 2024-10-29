import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:troqueles_sw/presentation/widgets/custom_search_bar.dart';
import 'package:troqueles_sw/presentation/widgets/custom_table_widget.dart';

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
    return NavigationView(
      appBar: const NavigationAppBar(
          leading: Center(
              child: Image(
            image: AssetImage('assets/Smurfit_Westrock_(logo).png'),
          )),
          title: Center(child: CustomSearchBar())),

      pane: NavigationPane(
        header: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: DefaultTextStyle(
            style: FluentTheme.of(context).typography.title!,
            child: const Text('Menu'),
          ),
        ),
        items: [
          PaneItem(
            icon: const Icon(Icons.home),
            body: const Image(
              image: NetworkImage(
                  'https://packagingsuppliersglobal.com/assets/uploads/_headerImagery/35883/Smurfit-Westrock.webp'),
              fit: BoxFit.cover,
            ),
            title: const Text('Inicio'),
          ),
          PaneItemHeader(header: const Text('Troqueles')),
          PaneItemExpander(
              body: const TroquelTable(),
              title: const Text('Bibliaco'),
              icon: const Icon(Icons.book_rounded),
              items: [
                PaneItemHeader(header: const Text('Maquinas')),
                PaneItem(
                  icon: const Icon(Icons.factory),
                  body: const Text('Ward'),
                  title: const Text('Ward'),
                ),
                PaneItem(
                  icon: const Icon(Icons.factory),
                  body: const Text('Screen2'),
                  title: const Text('Flexo Ward'),
                ),
                PaneItem(
                  icon: const Icon(Icons.factory),
                  body: const Text('Screen3'),
                  title: const Text('Holandeza'),
                ),
                PaneItem(
                  icon: const Icon(Icons.factory),
                  body: const Text('Screen4'),
                  title: const Text('Js Machine'),
                ),
                PaneItem(
                  icon: const Icon(Icons.factory),
                  body: const Text('Screen4'),
                  title: const Text('Mini line'),
                ),
              ]),
          PaneItem(
            icon: const Icon(Icons.autorenew),
            body: const Text('Screen2'),
            title: const Text('Troqueles en proceso'),
          ),
          PaneItem(
            icon: const Icon(Icons.fact_check_outlined),
            body: const Text('Screen3'),
            title: const Text('Troqueles terminados'),
          ),
          PaneItem(
            icon: const Icon(Icons.construction),
            body: const Text('Screen4'),
            title: const Text('Troqueles Mantenimiento'),
          ),
          PaneItem(
            icon: const Icon(Icons.delete_forever),
            body: const Text(''),
            title: const Text('Troqueles Obsoletos'),
          ),
          PaneItemHeader(header: const Text('Acesibilidad')),
          PaneItem(
            icon: const Icon(Icons.autorenew),
            body: const Text('Screen2'),
            title: const Text('Troqueles en proceso'),
          ),
          PaneItem(
            icon: const Icon(Icons.fact_check_outlined),
            body: const Text('Screen3'),
            title: const Text('Troqueles terminados'),
          ),
          PaneItem(
            icon: const Icon(Icons.construction),
            body: const Text('Screen4'),
            title: const Text('Troqueles Mantenimiento'),
          ),
          PaneItem(
            icon: const Icon(Icons.delete_forever),
            body: const Text(''),
            title: const Text('Troqueles Obsoletos'),
          ),
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
