
import 'dart:io';
import 'package:troqueles_sw/domain/entities/troqueles.dart';

abstract class TroquelRepositories {
  Future<List<Troquel>> seleccionarArchivoExcel(String sheetName);
  Future<List<Troquel>> importarTroquelesDesdeExcel(File file, String sheetName);
}