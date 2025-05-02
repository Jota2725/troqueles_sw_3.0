import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/presentation/providers/theme_provider.dart';

class AccessibilityScreen extends ConsumerWidget {
  const AccessibilityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(themeModeCustomProvider);
    final fontSize = ref.watch(fontSizeProvider);

    return ScaffoldPage(
      header: const PageHeader(title: Text('Accesibilidad')),
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Modo de tema:',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildThemeRadio(context, ref, ThemeModeCustom.light, 'Claro'),
                _buildThemeRadio(context, ref, ThemeModeCustom.dark, 'Oscuro'),
                _buildThemeRadio(context, ref, ThemeModeCustom.highContrast,
                    'Alto contraste'),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Tamaño de fuente:',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 10),
            Slider(
              min: 12.0,
              max: 24.0,
              value: fontSize,
              onChanged: (value) {
                ref.read(fontSizeProvider.notifier).setFontSize(value);
              },
            ),
            const SizedBox(height: 10),
            Button(
              onPressed: () {
                ref.read(fontSizeProvider.notifier).setFontSize(16.0);
              },
              child: const Text('Restaurar tamaño predeterminado'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeRadio(
    BuildContext context,
    WidgetRef ref,
    ThemeModeCustom mode,
    String label,
  ) {
    final currentMode = ref.watch(themeModeCustomProvider);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RadioButton(
          checked: currentMode == mode,
          onChanged: (_) {
            ref.read(themeModeCustomProvider.notifier).setTheme(mode);
          },
        ),
        const SizedBox(width: 4),
        Text(label),
        const SizedBox(width: 20),
      ],
    );
  }
}
