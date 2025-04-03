import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/presentation/screens/accessibility/accessibility_provider.dart';

class AccessibilityScreen extends ConsumerStatefulWidget {
  const AccessibilityScreen({super.key});

  @override
  _AccessibilityScreenState createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends ConsumerState<AccessibilityScreen> {
  @override
  Widget build(BuildContext context) {
    final accessibility = ref.watch(accessibilityProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Accesibilidad')),
      backgroundColor:
          accessibility.isHighContrast ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Opciones de Accesibilidad",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color:
                    accessibility.isHighContrast ? Colors.yellow : Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Switch para Modo Alto Contraste
            SwitchListTile(
              title: Text(
                "Modo Alto Contraste",
                style: TextStyle(
                  fontSize: accessibility.fontSize,
                  color: accessibility.isHighContrast
                      ? Colors.yellow
                      : Colors.black,
                ),
              ),
              value: accessibility.isHighContrast,
              onChanged: (value) {
                ref.read(accessibilityProvider.notifier).toggleHighContrast();
                setState(() {}); // Asegura que la UI se actualice
              },
            ),
            const SizedBox(height: 20),

            // Ajuste de tamaño de fuente
            Text(
              "Tamaño de Fuente",
              style: TextStyle(
                fontSize: accessibility.fontSize,
                color:
                    accessibility.isHighContrast ? Colors.yellow : Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(accessibilityProvider.notifier).decreaseFont();
                    setState(() {}); // Actualiza la UI
                  },
                  child: const Text("A-"),
                ),
                const SizedBox(width: 10),
                Text(
                  "${accessibility.fontSize.toInt()} px",
                  style: TextStyle(
                    fontSize: accessibility.fontSize,
                    color: accessibility.isHighContrast
                        ? Colors.yellow
                        : Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    ref.read(accessibilityProvider.notifier).increaseFont();
                    setState(() {}); // Actualiza la UI
                  },
                  child: const Text("A+"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
