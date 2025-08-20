class GeneralInfo {
  final String ntroquel;
  final String cliente;
  final String planta;
  final double totalDibCal;
  final double totalEncEng;
  final double totalTiempo;
  final double totalCuchiEsc;

  GeneralInfo({
    required this.ntroquel,
    required this.cliente,
    required this.planta,
    required this.totalDibCal,
    required this.totalEncEng,
    required this.totalTiempo,
    required this.totalCuchiEsc,
  });

  GeneralInfo copyWith({
    String? ntroquel,
    String? cliente,
    String? planta,
    double? totalDibCal,
    double? totalEncEng,
    double? totalTiempo,
    double? totalCuchiEsc,
  }) {
    return GeneralInfo(
      ntroquel: ntroquel ?? this.ntroquel,
      cliente: cliente ?? this.cliente,
      planta: planta ?? this.planta,
      totalDibCal: totalDibCal ?? this.totalDibCal,
      totalEncEng: totalEncEng ?? this.totalEncEng,
      totalTiempo: totalTiempo ?? this.totalTiempo,
      totalCuchiEsc: totalCuchiEsc ?? this.totalCuchiEsc,
    );
  }

  // Útil si en IsarDatasource construyes desde Proceso
  factory GeneralInfo.fromProceso({
    required String ntroquel,
    required String cliente,
    required String planta,
  }) {
    return GeneralInfo(
      ntroquel: ntroquel,
      cliente: cliente,
      planta: planta,
      totalDibCal: 0,
      totalEncEng: 0,
      totalTiempo: 0,
      totalCuchiEsc: 0,
    );
  }
}
