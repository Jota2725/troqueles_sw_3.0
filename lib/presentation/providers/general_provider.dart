import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';
import 'package:troqueles_sw/domain/entities/general_info.dart';

final generalProvider = FutureProvider<List<GeneralInfo>>((ref) async {
  final isar = IsarDatasource();
  return await isar.getResumenGeneral();
});
