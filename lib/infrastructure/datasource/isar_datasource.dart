import 'dart:async';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:troqueles_sw/domain/datasource/local_storage_datasource.dart';
import 'package:troqueles_sw/domain/entities/consumo.dart';
import 'package:troqueles_sw/domain/entities/materiales.dart';
import 'package:troqueles_sw/domain/entities/troquel.dart';
import '../../domain/entities/operario.dart';
import '../../domain/entities/proceso.dart';
import '../../domain/entities/tiempos.dart';
import '../../domain/entities/general_info.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;
  late String installDir;
  late String lockfile;

  IsarDatasource() {
    installDir = getInstallDir();
    lockfile = '$installDir/app.lock';
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [
          TroquelSchema,
          ProcesoSchema,
          ConsumoSchema,
          MaterialesSchema,
          OperarioSchema,
          TiemposSchema
        ],
        directory: installDir,
        inspector: true,
        // Permitir lectura en modo seguro
      );
    }
    return Future.value(Isar.getInstance());
  }

  String getInstallDir() {
    final installDir = Directory.current.path;
    return installDir;
  }

  Future<void> deleteLockfile() async {
    final lockfilep = File(lockfile);
    if (await lockfilep.exists()) {
      await lockfilep.delete();
    }
  }

  Future<void> closeDB() async {
    await deleteLockfile();
  }

  // -----------------------------------------CRUD DE TROQUELES ----------------------------------------------

  // GUARDAR TROQUEL
  @override
  Future<void> saveTroqueles(List<Troquel> troqueles) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.troquels.putAll(troqueles);
    });
  }

  //OBTENER TODOS LOS TROQUELES
  @override
  Future<List<Troquel>> getAllTroqueles() async {
    final isar = await db;
    final troqueles = await isar.troquels.where().findAll();

    return troqueles;
  }

  // ELIMINAR TODOS LOS TROQUELES
  @override
  Future<void> deleteAllTroqueles() async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.troquels.clear();
    });
  }

  // BORRAR TROQUEL
  @override
  Future<void> deleteTroquel(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.troquels.delete(id);
    });
  }

  Future<void> deleteMaterialById(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.materiales.delete(id);
    });
  }

  // OBTENER TROQUEL POR ID
  @override
  Future<Troquel?> getTroquelByGicoAndMaquina(int gico, String maquina) async {
    final isar = await db;
    final troquel = await isar.troquels
        .filter()
        .gicoEqualTo(gico)
        .and()
        .maquinaEqualTo(maquina)
        .findFirst();

    return troquel;
  }

  //ACTUALIZAR TROQUEL
  @override
  Future<void> updateTroquel(Troquel troquel) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final updatedTroquel = Troquel(
        nota: troquel.nota,
        ubicacion: troquel.ubicacion,
        gico: troquel.gico,
        cliente: troquel.cliente,
        no_cad: troquel.no_cad,
        referencia: troquel.referencia,
        maquina: troquel.maquina,
        clave: troquel.clave,
        largo: troquel.largo,
        ancho: troquel.ancho,
        alto: troquel.alto,
        cabida: troquel.cabida,
        estilo: troquel.estilo,
        descripcion: troquel.descripcion,
      )..isarId = troquel.isarId;

      await isar.troquels.put(updatedTroquel);
    });
  }

  @override
  Future<void> deleteAllTroquelesbyMachine(String maquina) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.troquels.filter().maquinaEqualTo(maquina).deleteAll();
    });
  }

  @override
  Future<List<Troquel>> getAllTroquelesPorMaquina(String maquina) async {
    final isar = await db;
    final troqueles =
        await isar.troquels.filter().maquinaEqualTo(maquina).findAll();

    return troqueles;
  }

  @override
  Future<List<Troquel>> getTroquelesLibres(String maquina) async {
    final isar = await db;
    final query = isar.troquels
        .where()
        .filter()
        .ubicacionEqualTo('')
        .or()
        .ubicacionIsNull()
        .and()
        .maquinaEqualTo(maquina);
    final troqueles = await query.findAll();

    return troqueles;
  }

//-------------------------------------------------------Troqueles en proceso------------------------------------------------------------------------------------------------------
  @override
  Future<List<Proceso>> getAllTroquelesInProcess() async {
    final isar = await db;

    final procesos = await isar.procesos.where().findAll();

    return procesos;
  }

  Future<List<Proceso>> getTroquelesByEstado(Estado estado) async {
    final isar = await db;
    final procesos =
        await isar.procesos.where().filter().estadoEqualTo(estado).findAll();

    return procesos;
  }

  Future<Proceso?> getTroquelInProcess(String troquel) async {
    final isar = await db;
    final proceso =
        await isar.procesos.filter().ntroquelEqualTo(troquel).findFirst();

    return proceso;
  }

  @override
  Future<void> addNewTroquelInProcess(List<Proceso> proceso) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.procesos.putAll(proceso);
    });
  }

  @override
  Future<void> deleteTroquelInProcees(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.procesos.delete(id);
    });
  }

  @override
  Future<void> updatedTroquelInProcess(Proceso proceso) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final updatedProceso = Proceso(
          ntroquel: proceso.ntroquel,
          fechaIngreso: proceso.fechaIngreso,
          fechaEstimada: proceso.fechaEstimada,
          planta: proceso.planta,
          cliente: proceso.cliente,
          maquina: proceso.maquina,
          ingeniero: proceso.ingeniero,
          observaciones: proceso.observaciones,
          estado: proceso.estado)
        ..isarId = proceso.isarId;

      await isar.procesos.put(updatedProceso);
    });
  }

  @override
  Future<List<Consumo>> getAllConsumos() async {
    final isar = await db;
    final consumos = await isar.consumos.where().findAll();

    return consumos;
  }

  //----------------------MATERIALES---------------------------------------
  @override
  Future<List<Materiales>> gettAllMateriles() async {
    final isar = await db;
    final materiales = await isar.materiales.where().findAll();

    return materiales;
  }

  Future<void> addNewMaterial(List<Materiales> materiales) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.materiales.putAll(materiales);
    });
  }

  Future<void> addNewConsumo(List<Consumo> consumos) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.consumos.putAll(consumos);

      for (var i = 0; i < consumos.length; i++) {
        final consumo = consumos[i];
        // Asegúrate de que los materiales estén asociados al consumo correcto
        consumo.materiales.save();
      }
    });
  }

  // Eliminar consumo por ID
  Future<void> deleteConsumo(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.consumos.delete(id);
    });
  }

  Future<void> updateConsumo(Consumo updatedConsumo) async {
    final isar = await db;
    await isar.writeTxn(() async {
      // Primero se guarda el objeto Consumo
      await isar.consumos.put(updatedConsumo);

      // Luego se guarda el enlace con los materiales
      await updatedConsumo.materiales.save();
    });
  }

//TIEMPOS CRUD
  Future<List<Tiempos>> getAllTiempos() async {
    final isar = await db;
    final tiempos = await isar.tiempos.where().findAll();

    return tiempos;
  }

  Future<void> addNewTiempo(List<Tiempos> tiempos) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.tiempos.putAll(tiempos);
    });
  }

  Future<void> uptadeTime(Tiempos tiempo) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final updateTiempos = Tiempos(
          operarios: tiempo.operarios,
          fecha: tiempo.fecha,
          ntroquel: tiempo.ntroquel,
          tiempo: tiempo.tiempo,
          actividad: tiempo.actividad)
        ..isarId = tiempo.isarId;
      await isar.tiempos.put(updateTiempos);
    });
  }

  Future<void> deleteTiempos(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.tiempos.delete(id);
    });
  }

  Future<List<Operario>> getAllOperarios() async {
    final isar = await db;
    final operario = await isar.operarios.where().findAll();

    return operario;
  }

  Future<void> addNewOperarios(List<Operario> operarios) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.operarios.putAll(operarios);
    });
  }

  Future<List<GeneralInfo>> getResumenGeneral() async {
    final isar = await db;

    // Obtener todos los datos necesarios
    final tiempos = await isar.tiempos.where().findAll();
    final consumos = await isar.consumos.where().findAll();
    final procesos = await isar.procesos.where().findAll();

    final Map<String, GeneralInfo> resumen = {};

    // Procesar tiempos
    for (final tiempo in tiempos) {
      final key = tiempo.ntroquel;

      final proceso = procesos.firstWhere(
        (p) => p.ntroquel == key,
        orElse: () => Proceso(
          ntroquel: key,
          fechaIngreso: DateTime.now(),
          planta: '',
          cliente: '',
          maquina: '',
          ingeniero: '',
          observaciones: '',
          estado: Estado.pendiente,
        ),
      );

      resumen[key] ??= GeneralInfo.fromProceso(
        ntroquel: tiempo.ntroquel,
        cliente: proceso.cliente,
        planta: proceso.planta,
      );

      final actividad = tiempo.actividad;
      final tiempoHoras = tiempo.tiempo;

      resumen[key] = resumen[key]!.copyWith(
        totalDibCal: resumen[key]!.totalDibCal +
            (actividad == Actividad.Dibujo ||
                    actividad == Actividad.Punteado ||
                    actividad == Actividad.Calado
                ? tiempoHoras
                : 0),
        totalEncEng: resumen[key]!.totalEncEng +
            (actividad == Actividad.Encuchillado ||
                    actividad == Actividad.Engomado
                ? tiempoHoras
                : 0),
        totalTiempo: resumen[key]!.totalTiempo + tiempoHoras,
      );
    }

    // Procesar consumos
    for (final consumo in consumos) {
      final key = consumo.nTroquel;

      if (resumen.containsKey(key)) {
        double cuchi = 0;
        double escore = 0;

        if (consumo.tipo.toLowerCase() == 'cuchillas') {
          cuchi = consumo.cantidad.toDouble();
        } else if (consumo.tipo.toLowerCase() == 'escores') {
          escore = consumo.cantidad.toDouble();
        }

        resumen[key] = resumen[key]!.copyWith(
          totalCuchiEsc: resumen[key]!.totalCuchiEsc + cuchi + escore,
        );
      }
    }

    return resumen.values.toList();
  }
}
