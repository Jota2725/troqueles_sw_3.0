import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:troqueles_sw/domain/entities/materiales.dart';
import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';

import '../../domain/datasource/materiales.datasource.dart';

class MaterialesDatasourceImpl implements MaterialesDatasource {
  final IsarDatasource _isarDatasource = IsarDatasource();

  @override
  Future<List<Materiales>> seleccionarArchivoExcel(String sheetName) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls','xlsm'],
    );

    if (result != null) {
      return importarMaterialesDesdeExcel(
          File(result.files.single.path!), sheetName);
    }
    return [];
  }

  @override
  Future<List<Materiales>> importarMaterialesDesdeExcel(
      File file, String sheetName) async {
    var bytes = await file.readAsBytes();
    var excel = Excel.decodeBytes(bytes);
    List<Materiales> materiales = [];
    var sheet = excel.tables[sheetName];

    if (sheet != null) {
      for (var row in sheet.rows.skip(1)) {
        materiales.add(Materiales(
            codigo: int.parse(row[0]?.value.toString() ?? '1'),
            unidad: convertirUnidad(row[3]?.value.toString() ?? ''),
            descripcion: (row[4]?.value.toString() ?? ''),
            tipo: convertirTipo(row[5]?.value.toString() ?? ''),
            conversion: double.parse(row[7]?.value.toString() ?? '1')));
      }
    }
    
    await _isarDatasource.addNewMaterial(materiales);

    return materiales;
  }
}

Unidad convertirUnidad(String valor) {
  switch (valor) {
    case 'CM2':
      return Unidad.cm2;
    case 'CM':
      return Unidad.cm;
    case 'Tiras':
      return Unidad.tiras;
    case 'Rollo':
      return Unidad.rollo;
    case 'UND':
      return Unidad.und;
    case 'KIT':
      return Unidad.kit;
    case 'PAR':
      return Unidad.par;
    case 'mts':
      return Unidad.mts;
    case 'Caja':
      return Unidad.caja;
    case 'Doc':
      return Unidad.doc;
    case 'Bolsa':
      return Unidad.bolsa;
    case 'Tiras-Plan':
      return Unidad.tiras_plan;
    case 'Plancha' || 'Und Plancha':
      return Unidad.plancha;

    default:
      return Unidad.und;
  }
}

Tipo convertirTipo(String value) {
  switch (value) {
    case 'Madera':
      return Tipo.maderas;
    case 'Goma':
      return Tipo.gomas;
    case 'Score':
      return Tipo.escores;
    case 'Herramienta':
      return Tipo.herramientas;
    case 'Cuchilla':
      return Tipo.cuchillas;
    case 'Prealistamiento':
      return Tipo.prealistamientos;
    case 'Aros':
      return Tipo.aros;

    default:
      return Tipo.maderas;
    
  }
}
