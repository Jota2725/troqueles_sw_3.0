import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  static const name = 'Navegation_Screen';
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        leading: Center(
          child: FlutterLogo(
            size: 25,
          ),
        ),
      ),
      pane: NavigationPane(
        header: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: DefaultTextStyle(
            style: FluentTheme.of(context).typography.title!,
            child: const Text('Smurfit'),
          ),
        ),
        items: [
          PaneItem(
            icon: const Icon(Icons.book_rounded),
            body: const Text('Screen1'),
            title: const Text('Bibliaco'),
          ),
          PaneItem(
            icon: const Icon(Icons.autorenew),
            body: const Text('Screen2'),
            title: const Text('Troqueles en proceso'),
          ),
          PaneItem(
            icon: const Icon(Icons.fact_check_outlined),
            body: const Text('Screen1'),
            title: const Text('Troqueles terminados'),
          ),
          PaneItem(
            icon: const Icon(Icons.construction),
            body: const Text('Screen1'),
            title: const Text('Troqueles'),
          ),
        ],
      ),
    );
  }
}
