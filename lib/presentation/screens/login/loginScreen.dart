import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:troqueles_sw/config/user_type.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isJefeSelected = false;
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
    return Scaffold(
      backgroundColor: Colors.white,
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
                const Center(
                  child: Text(
                    'Bienvenidos',
                    style: TextStyle(
                      fontSize: 80,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
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
                  const Image(
                    image: AssetImage('assets/Smurfit_Westrock_(logo).png'),
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
                          const Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Botón Operario
                          FilledButton(
                            onPressed: () {
                              _navigateToNavigationScreen(UserType.operario);
                            },
                            child: const Text('Entrar como Operario',
                                style: TextStyle(fontSize: 18)),
                          ),

                          const SizedBox(height: 16),

                          // Botón Jefe
                          OutlinedButton(
                            onPressed: () {
                              setState(() => _isJefeSelected = true);
                            },
                            child: const Text('Entrar como Jefe',
                                style: TextStyle(fontSize: 18)),
                          ),

                          // Campo de Contraseña
                          if (_isJefeSelected) ...[
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Contraseña',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(Icons.lock),
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
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _navigateToNavigationScreen(UserType.jefe);
                                }
                              },
                              icon: const Icon(Icons.check),
                              label: const Text('Ingresar como Jefe',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('By Runyy 25/02/2025')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
