
import 'dart:io';

import 'package:troqueles_sw/domain/entities/materiales.dart';

abstract class MaterialesDatasource {
  Future<List<Materiales>> seleccionarArchivoExcel(String sheetName);
  Future<List<Materiales>> importarMaterialesDesdeExcel(File file, String sheetName);
}