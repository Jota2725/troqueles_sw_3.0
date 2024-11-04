
import 'dart:io';
import 'package:troqueles_sw/domain/entities/troquel.dart';

abstract class TroquelDatasource {
  Future<List<Troquel>> seleccionarArchivoExcel(String sheetName);
  Future<List<Troquel>> importarTroquelesDesdeExcel(File file, String sheetName);
}