import 'package:flutter/cupertino.dart';
import 'package:troqueles_sw/domain/entities/tiempos.dart';
import 'package:troqueles_sw/utils/validators.dart';

class Tiemposformcontrollers {
  final Tiempos? tiempos;
  final requirefields = [
    "fecha",
    "Numero Troquel",
    "Actividad",
    'Operario',
    "Tiempo",
  ];
  String? selectedActividad;
  final controllers = <String, TextEditingController>{};
  Tiemposformcontrollers(this.tiempos) {
    final fields = [
      "fecha",
      "Numero Troquel",
      "Actividad",
      'Operario',
      "Tiempo",
    ];
    for (var field in fields) {
      controllers[field] = TextEditingController();
    }

    if (tiempos != null) {
      controllers["fecha"]!.text = tiempos!.fecha;
      controllers["Numero Troquel"]!.text = tiempos!.ntroquel;
      controllers["Actividad"]!.text = tiempos!.actividad.name;
      controllers['Operario']!.text = tiempos!.operarios ?? '';
      controllers["Tiempo"]!.text = "${tiempos!.tiempo}";
      selectedActividad = actividadToString(tiempos!.actividad);
    }
  }
  bool validateFields(BuildContext context) {
    for (var field in requirefields) {
      if (controllers[field]!.text.trim().isEmpty) {
        showError(context, "El campo ${field} es obligatorio. ");
        return false;
      }
    }
    return true;
  }

  Tiempos buildTiempos() {
    return Tiempos(
        fecha: controllers["fecha"]?.text ?? "",
        ntroquel: controllers["Numero Troquel"]?.text ?? "",
        tiempo: double.tryParse(controllers["Tiempo"]?.text ?? "0") ?? 0,
        operarios: controllers['Operario']?.text ?? '',
        actividad: selectedActividad != null
            ? stringToActividad(selectedActividad!)
            : Actividad.Calado);
  }

  Actividad stringToActividad(String value) {
    switch (value) {
      case 'Calado':
        return Actividad.Calado;
      case "Encuchillado":
        return Actividad.Encuchillado;
      case "Dibujo":
        return Actividad.Dibujo;
      case "Punteado":
        return Actividad.Punteado;
      case "Serrapid":
        return Actividad.Serrapid;
      case "Engomado":
        return Actividad.Engomado;
      case "Prueba":
        return Actividad.Prueba;
      case "Empaque":
        return Actividad.Empaque;

      default:
        throw ArgumentError('Estado inválido: $value');
    }
  }

  String actividadToString(Actividad actividad) {
    switch (actividad) {
      case Actividad.Calado:
        return 'Calado';
      case Actividad.Dibujo:
        return "Dibujo";
      case Actividad.Encuchillado:
        return "Encuchillado";
      case Actividad.Punteado:
        return "Punteado";
      case Actividad.Serrapid:
        return "Serrapid";
      case Actividad.Engomado:
        return "Engomado";
      case Actividad.Prueba:
        return "Prueba";
      case Actividad.Empaque:
        return "Empaque";

      default:
        throw ArgumentError('Estado inválido: $actividad');
    }
  }
}
