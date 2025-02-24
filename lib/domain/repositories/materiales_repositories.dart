

import 'dart:io';

import 'package:troqueles_sw/domain/entities/materiales.dart';

abstract class MaterialesRepositories {
  Future<List<Materiales>> seleccionarArchivoExcel(String sheetName);
  Future<List<Materiales>> importarTroquelesDesdeExcel(File file, String sheetName);
}