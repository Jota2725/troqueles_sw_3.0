import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:troqueles_sw/config/user_type.dart';
import 'package:troqueles_sw/presentation/screens/accessibility/accessibility_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isJefeSelected = false;
  bool _obscurePassword = true; // Estado para ocultar/mostrar la contraseña
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
    final accessibility = ref.watch(accessibilityProvider);
    final bool isHighContrast = accessibility.isHighContrast;

    return Scaffold(
      backgroundColor: isHighContrast ? Colors.black : Colors.white,
      body: Row(
        children: [
          // Panel de Imagen
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
                  child: Text(
                    'Bienvenidos',
                    style: TextStyle(
                      fontSize: 80,
                      color: isHighContrast ? Colors.yellow : Colors.white,
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
          // Panel de Login
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/Smurfit_Westrock_(logo).png',
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),

                  // Card de Inicio de Sesión
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color:
                                  isHighContrast ? Colors.yellow : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Botón Operario
                          FilledButton(
                            onPressed: () {
                              _navigateToNavigationScreen(UserType.operario);
                            },
                            child: Text(
                              'Entrar como Operario',
                              style: TextStyle(
                                fontSize: 18,
                                color: isHighContrast
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Botón Jefe
                          OutlinedButton(
                            onPressed: () {
                              setState(() => _isJefeSelected = true);
                            },
                            child: Text(
                              'Entrar como Jefe',
                              style: TextStyle(
                                fontSize: 18,
                                color: isHighContrast
                                    ? Colors.yellow
                                    : Colors.black,
                              ),
                            ),
                          ),

                          // Campo de Contraseña
                          if (_isJefeSelected) ...[
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Contraseña',
                                labelStyle: TextStyle(
                                  color: isHighContrast
                                      ? Colors.yellow
                                      : Colors.black,
                                ),
                                filled: true,
                                fillColor: isHighContrast
                                    ? Colors.black
                                    : Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: isHighContrast
                                        ? Colors.yellow
                                        : Colors.grey,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: isHighContrast
                                      ? Colors.yellow
                                      : Colors.black,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: isHighContrast
                                        ? Colors.yellow
                                        : Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              style: TextStyle(
                                color: isHighContrast
                                    ? Colors.yellow
                                    : Colors.black,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese la contraseña';
                                }
                                if (value != _jefePassword) {
                                  return 'Contraseña incorrecta';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Botón Confirmar Jefe
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isHighContrast
                                    ? Colors.yellow
                                    : Colors.green,
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
                              label: Text(
                                'Ingresar como Jefe',
                                style: TextStyle(
                                  fontSize: 18,
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
                  Text(
                    'By Runyy 25/02/2025',
                    style: TextStyle(
                      color: isHighContrast ? Colors.yellow : Colors.black,
                    ),
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
