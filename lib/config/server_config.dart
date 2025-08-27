// lib/config/server_config.dart
/// Config simple para resolver la URL base del backend.
/// - Por defecto toma la constante de build `SERVER_BASE` si la defines.
/// - Si no, usa un fallback (cámbialo por la IP real del servidor).
class ServerConfig {
  static String? _overrideBaseUrl;

  // Puedes pasar esta constante al compilar:
  // flutter run --dart-define=SERVER_BASE=http://192.168.1.50:8080
  static const String _defaultFromDefine =
      String.fromEnvironment('SERVER_BASE', defaultValue: '');

  // Fallback (cámbialo a la IP/puerto del PC servidor)
  static const String _fallback = 'http://192.168.1.100:8080';

  /// Obtiene la base URL efectiva.
  static Future<String> getBaseUrl() async {
    if (_overrideBaseUrl != null && _overrideBaseUrl!.isNotEmpty) {
      return _overrideBaseUrl!;
    }
    if (_defaultFromDefine.isNotEmpty) return _defaultFromDefine;
    return _fallback;
  }

  /// Permite cambiarla en runtime (por ejemplo, desde una pantalla de ajustes).
  static void setBaseUrl(String url) {
    _overrideBaseUrl = url;
  }
}
