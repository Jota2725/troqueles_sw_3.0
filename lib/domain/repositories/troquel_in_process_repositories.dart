

import 'package:troqueles_sw/domain/entities/proceso.dart';

abstract class TroquelInProcessRepositories {
  Future<void> addNewTroquel(List<Proceso> proceso);
  Future<List<Proceso>> getAllTroquelesInProcess();
  Future<void> updateTroquelInProcces(Proceso proceso);
  Future<void> deleteTroquelInProcees(int id);
}