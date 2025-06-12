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

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isJefeSelected = false;
  bool _obscurePassword = true;
  final String _jefePassword = "Abundancia2025*";

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    );

    _logoController.forward();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _slideController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  void _navigateToNavigationScreen(UserType userType) {
    if (userType == UserType.operario || _formKey.currentState!.validate()) {
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
    Color getBienvenidaColor() => Colors.white;

    return Scaffold(
      backgroundColor: getBackgroundColor(),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/SWforestal.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Text(
                    'Bienvenidos',
                    style: TextStyle(
                      fontSize: 90,
                      color: getBienvenidaColor(),
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
                  ScaleTransition(
                    scale: _logoAnimation,
                    child: Image.asset(
                      'assets/Smurfit_Westrock_(logo).png',
                      fit: BoxFit.contain,
                    ),
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
                          if (!_isJefeSelected) ...[
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: FilledButton.icon(
                                onPressed: () {
                                  _navigateToNavigationScreen(
                                      UserType.operario);
                                },
                                icon: const Icon(Icons.person_outline),
                                label: const ScaledText('Entrar como Operario'),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                    (states) =>
                                        states.contains(MaterialState.hovered)
                                            ? const Color(0xFF8A8A8A)
                                            : const Color(0xFFA5A5A5),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                  ),
                                  shadowColor:
                                      MaterialStateProperty.all(Colors.black54),
                                  elevation: MaterialStateProperty.all(4),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: FilledButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _isJefeSelected = true;
                                    _slideController.forward();
                                  });
                                },
                                icon: const Icon(Icons.verified_user),
                                label: const ScaledText('Entrar como Jefe'),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                    (states) =>
                                        states.contains(MaterialState.hovered)
                                            ? const Color(0xFF0070CC)
                                            : const Color(0xFF008CFF),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                  ),
                                  shadowColor:
                                      MaterialStateProperty.all(Colors.black45),
                                  elevation: MaterialStateProperty.all(5),
                                ),
                              ),
                            ),
                          ],
                          if (_isJefeSelected)
                            SlideTransition(
                              position: _slideAnimation,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    decoration: InputDecoration(
                                      labelText: 'Contraseña',
                                      labelStyle:
                                          TextStyle(color: getTextColor()),
                                      filled: true,
                                      fillColor: getBackgroundColor(),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: getTextColor()),
                                      ),
                                      prefixIcon: Icon(Icons.lock,
                                          color: getTextColor()),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: getTextColor(),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
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
                                        _navigateToNavigationScreen(
                                            UserType.jefe);
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF008CFF),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                      elevation: 4,
                                      shadowColor: Colors.black54,
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _navigateToNavigationScreen(
                                            UserType.jefe);
                                      }
                                    },
                                    icon: const Icon(Icons.check,
                                        color: Colors.white),
                                    label: const ScaledText(
                                      'Ingresar como Jefe',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ScaledText(
                      'Troqueles SW, v2.0',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
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
