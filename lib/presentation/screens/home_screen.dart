import 'package:flutter/material.dart';
import 'package:troqueles_sw/config/user_type.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'Home-Screen';
  final UserType userType;

  const HomeScreen({super.key, required this.userType});

  @override
  State<HomeScreen> createState() => _MyhomeWidgetState();
}

class _MyhomeWidgetState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool _showBanner = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _showBanner = false);
      }
    });
  }

  String getWelcomeMessage() {
    return widget.userType == UserType.jefe
        ? "Bienvenida, Pilar Narvaez"
        : "Bienvenido, operario";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo de imagen
        Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.centerRight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Sustainability.png'),
              fit: BoxFit.contain,
              alignment: Alignment.centerRight,
            ),
          ),
        ),
        // Banner animado
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          top: _showBanner ? 20 : -100,
          left: 20,
          right: 20,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: _showBanner ? 1.0 : 0.0,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              color: Colors.green.shade200,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Text(
                  getWelcomeMessage(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
