import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Troqueles Smurfit WestRock',
      home: MyhomeWidget(),
    );
  }
}

final List<Troquel> _listTroquel = [
  Troquel(432, 3566, 'Agro', 18476301, 'WARD'),
  Troquel(434, 3587, 'Bivien', 18547701, 'WARD'),
  Troquel(567, 3566, 'Agro', 18375001, 'WARD'),
  Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
  Troquel(907, 3566, 'Agro', 18375001, 'WARD'),
  Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
  Troquel(432, 3566, 'Agro', 18476301, 'WARD'),
  Troquel(434, 3587, 'Bivien', 18547701, 'WARD'),
  Troquel(567, 3566, 'Agro', 18375001, 'WARD'),
  Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
  Troquel(907, 3566, 'Agro', 18375001, 'WARD'),
  Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
  Troquel(432, 3566, 'Agro', 18476301, 'WARD'),
  Troquel(434, 3587, 'Bivien', 18547701, 'WARD'),
  Troquel(567, 3566, 'Agro', 18375001, 'WARD'),
  Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
  Troquel(907, 3566, 'Agro', 18375001, 'WARD'),
  Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
  Troquel(432, 3566, 'Agro', 18476301, 'WARD'),
  Troquel(434, 3587, 'Bivien', 18547701, 'WARD'),
  Troquel(567, 3566, 'Agro', 18375001, 'WARD'),
  Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
  Troquel(907, 3566, 'Agro', 18375001, 'WARD'),
  Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
  Troquel(432, 3566, 'Agro', 18476301, 'WARD'),
  Troquel(434, 3587, 'Bivien', 18547701, 'WARD'),
  Troquel(567, 3566, 'Agro', 18375001, 'WARD'),
  Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
  Troquel(907, 3566, 'Agro', 18375001, 'WARD'),
  Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
  Troquel(432, 3566, 'Agro', 18476301, 'WARD'),
  Troquel(434, 3587, 'Bivien', 18547701, 'WARD'),
  Troquel(567, 3566, 'Agro', 18375001, 'WARD'),
  Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
  Troquel(907, 3566, 'Agro', 18375001, 'WARD'),
  Troquel(324, 3587, 'Bivien', 18375001, 'WARD'),
];

Widget _buildTable({bool sortAsscending = true}) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      children: [
        const SizedBox(
          height: 60,
          width: double.infinity,
          child:
              Padding(padding: EdgeInsets.all(6.0), child: CustomSearchBar()),
        ),
        SizedBox(
          width: double.infinity,
          child: DataTable(
            sortColumnIndex: 0,
            sortAscending: sortAsscending,
            columns: const <DataColumn>[
              DataColumn(
                  label: Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 15,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('Ubicación'),
                ],
              )),
              DataColumn(label: Text('Gico')),
              DataColumn(label: Text('Cliente')),
              DataColumn(label: Text('Referencia')),
              DataColumn(label: Text('Maquina')),
            ],
            rows: _listTroquel.map<DataRow>((Troquel troquel) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text('${troquel.ubicacion}')),
                  DataCell(Text('${troquel.gico}'),
                      showEditIcon: true, onTap: () {}),
                  DataCell(Text(troquel.cliente)),
                  DataCell(Text('${troquel.referencia}')),
                  DataCell(Text(troquel.maquina)),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

class MyhomeWidget extends StatefulWidget {
  const MyhomeWidget({super.key});

  @override
  State<MyhomeWidget> createState() => _MyhomeWidgetState();
}

class _MyhomeWidgetState extends State<MyhomeWidget> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text('TROQUELES SMURFIT WESTROCK',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromRGBO(23, 13, 171, 1),
          centerTitle: true),
      body: Row(
        children: [
          menuTroqueles(size: size),
          SizedBox(
            width: size.width * 0.8,
            // Ancho completo de la pantalla
            child: _buildTable(),
          ),
        ],
      ),
    );
  }
}

class menuTroqueles extends StatelessWidget {
  const menuTroqueles({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width * 0.2,
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            child: Image(
                image: AssetImage('assets/Smurfit_Westrock_(logo).png')),
          ),
          ListTile(
               hoverColor: Colors.blue.shade100,
              leading: const Icon(Icons.book_rounded),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              title: const Text('Bibliaco Troqueles'),
              onTap: () {}),
          const SizedBox(
            height: 10,
          ),
          ListTile(
               hoverColor: Colors.blue.shade100,
              leading: const Icon(Icons.autorenew),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              title: const Text('Troqueles en proceso'),
              onTap: () {}),
          const SizedBox(
            height: 10,
          ),
          ListTile(
              hoverColor: Colors.blue.shade100,
              leading: const Icon(Icons.fact_check_outlined),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              title: const Text('Troqueles Terminados'),
              onTap: () {}),
          const SizedBox(
            height: 10,
          ),
          ListTile(
              hoverColor: Colors.blue.shade100,
              leading: const Icon(Icons.construction),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              title: const Text('Troqueles en mantenimiento'),
              onTap: () {}),
        ],
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          elevation: const WidgetStatePropertyAll(0),
          controller: controller,
          padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
          leading: const Icon(Icons.search),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return List<ListTile>.generate(5, (int index) {
          final String item = 'item $index';
          return ListTile(
            title: Text(item),
            onTap: () {
              controller.closeView(item);
            },
          );
        });
      },
    );
  }
}

class Troquel {
  final int ubicacion;
  final int gico;
  final String cliente;
  final int referencia;
  final String maquina;

  Troquel(
      this.ubicacion, this.gico, this.cliente, this.referencia, this.maquina);
}
