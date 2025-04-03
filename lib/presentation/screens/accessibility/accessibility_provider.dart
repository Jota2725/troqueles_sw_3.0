import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessibilityProvider extends ChangeNotifier {
  double _fontSize = 16.0;
  bool _isHighContrast = false;

  double get fontSize => _fontSize;
  bool get isHighContrast => _isHighContrast;

  AccessibilityProvider() {
    _loadPreferences();
  }

  void increaseFont() {
    if (_fontSize < 24.0) {
      _fontSize += 2;
      _saveFontSize();
    }
  }

  void decreaseFont() {
    if (_fontSize > 12.0) {
      _fontSize -= 2;
      _saveFontSize();
    }
  }

  void toggleHighContrast() {
    _isHighContrast = !_isHighContrast;
    _saveHighContrast();
  }

  Future<void> _saveFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', _fontSize);
    notifyListeners(); // Notificar cambios después de guardar
  }

  Future<void> _saveHighContrast() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isHighContrast', _isHighContrast);
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble('fontSize') ?? 16.0;
    _isHighContrast = prefs.getBool('isHighContrast') ?? false;
    notifyListeners();
  }
}

final accessibilityProvider =
    ChangeNotifierProvider((ref) => AccessibilityProvider());
