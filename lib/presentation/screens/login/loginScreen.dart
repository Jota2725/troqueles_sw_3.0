import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:troqueles_sw/config/user_type.dart';
import 'package:troqueles_sw/presentation/providers/theme_provider.dart';
import 'package:troqueles_sw/presentation/widgets/scaled_text.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isJefeSelected = false;
  bool _obscurePassword = true;
  final String _jefePassword = "Abundancia2025*";

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateToNavigationScreen(UserType userType) {
    if (_formKey.currentState!.validate()) {
      context.go('/navigation/${userType.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeCustomProvider);
    final fontSize = ref.watch(fontSizeProvider);
    final isHighContrast = themeMode == ThemeModeCustom.highContrast;
    final isDark = themeMode == ThemeModeCustom.dark;

    Color getTextColor() =>
        isHighContrast ? Colors.yellow : (isDark ? Colors.white : Colors.black);
    Color getBackgroundColor() =>
        isHighContrast || isDark ? Colors.black : Colors.white;
    Color getButtonColor() =>
        isHighContrast ? Colors.yellow : (isDark ? Colors.blue : Colors.blue);

    return Scaffold(
      backgroundColor: getBackgroundColor(),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/Pino.jpg',
                  fit: BoxFit.cover,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),
                Center(
                  child: ScaledText(
                    'Bienvenidos',
                    style: TextStyle(
                      fontSize: 120,
                      color: getTextColor(),
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        Shadow(blurRadius: 10, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Smurfit_Westrock_(logo).png',
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ScaledText(
                            'Iniciar Sesión',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: getTextColor(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FilledButton(
                            onPressed: () {
                              _navigateToNavigationScreen(UserType.operario);
                            },
                            style: FilledButton.styleFrom(
                                backgroundColor: getButtonColor()),
                            child: ScaledText(
                              'Entrar como Operario',
                              style: TextStyle(
                                color: isHighContrast
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton(
                            onPressed: () {
                              setState(() => _isJefeSelected = true);
                            },
                            child: ScaledText(
                              'Entrar como Jefe',
                              style: TextStyle(
                                color: getTextColor(),
                              ),
                            ),
                          ),
                          if (_isJefeSelected) ...[
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Contraseña',
                                labelStyle: TextStyle(color: getTextColor()),
                                filled: true,
                                fillColor: getBackgroundColor(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: getTextColor()),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: getTextColor(),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: getTextColor(),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              style: TextStyle(color: getTextColor()),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese la contraseña';
                                }
                                if (value != _jefePassword) {
                                  return 'Contraseña incorrecta';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) {
                                if (_formKey.currentState!.validate()) {
                                  _navigateToNavigationScreen(UserType.jefe);
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: getButtonColor(),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _navigateToNavigationScreen(UserType.jefe);
                                }
                              },
                              icon: Icon(
                                Icons.check,
                                color: isHighContrast
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              label: ScaledText(
                                'Ingresar como Jefe',
                                style: TextStyle(
                                  color: isHighContrast
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ScaledText(
                    'By Runyy 25/02/2025',
                    style: TextStyle(color: getTextColor()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
