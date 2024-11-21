import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:troqueles_sw/domain/entities/proceso.dart';
import 'package:troqueles_sw/infrastructure/datasource/isar_datasource.dart';

import '../../../widgets/in_process_table.dart';

class TroquelViewPages extends ConsumerWidget {
  const TroquelViewPages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IsarDatasource isarInProceesDatasource = IsarDatasource();
    
        return Scaffold(
      appBar: AppBar(
        title: const Text('Troqueles en Proceso'),
        centerTitle: true,
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: FutureBuilder<List<Proceso>>(
        future: isarInProceesDatasource.getAllTroquelesInProcess(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay procesos en curso.'));
          } else {
            final List<Proceso> procesos = snapshot.data!;
            return PageView(
              scrollDirection: Axis.horizontal,
              children: [
                ProcesoTable(
                  procesos: procesos,
                )
          
              ],
     );
          }
        },
      ),
    );
  }
}