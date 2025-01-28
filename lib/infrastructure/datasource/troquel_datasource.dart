import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:troqueles_sw/domain/datasource/troquel_datasource.dart';
import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';
import '../../domain/entities/troquel.dart';

class TroquelDatasourceImpl implements TroquelDatasource {
  final IsarDatasource _isarDatasource = IsarDatasource();

  @override
  Future<List<Troquel>> seleccionarArchivoExcel(String sheetName) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      return importarTroquelesDesdeExcel(
          File(result.files.single.path!), sheetName);
    }
    return [];
  }

  @override
  Future<List<Troquel>> importarTroquelesDesdeExcel(
      File file, String sheetName) async {
    var bytes = await file.readAsBytes();
    var excel = Excel.decodeBytes(bytes);
    List<Troquel> troqueles = [];

    var sheet = excel.tables[sheetName];
    if (sheet != null) {
      for (var row in sheet.rows.skip(1)) {
        troqueles.add(
        Troquel(
          nota:  (row[0]?.value.toString() ?? '' ),
          ubicacion: (row[1]?.value.toString() ?? ''),
          gico: int.tryParse(row[2]?.value.toString() ?? '0') ?? 0,
          cliente: row[3]?.value.toString() ?? '',
          referencia: int.tryParse(row[4]?.value.toString() ?? '0') ?? 0,
          maquina: row[5]?.value.toString() ?? '',
          clave: row[6]?.value?.toString(),
          largo: row[7] != null
              ? int.tryParse(row[7]?.value.toString() ?? '')
              : null,
          ancho: row[8] != null
              ? int.tryParse(row[8]?.value.toString() ?? '')
              : null,
          alto: row[9] != null
              ? int.tryParse(row[9]?.value.toString() ?? '')
              : null,
          cabida: row[10] != null
              ? int.tryParse(row[10]?.value.toString() ?? '')
              : null,
          estilo: row[11]?.value?.toString(),
          descripcion: row[12]?.value?.toString(),
        ));
      }
    }
    await _isarDatasource.saveTroqueles(troqueles);
    return troqueles;
  }
}
