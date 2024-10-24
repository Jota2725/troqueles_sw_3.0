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
  Troquel(324, 3587, 'Bivien', 18375001, 'WARD')
];

Widget _buildTable({bool sortAsscending = true}) {
  return Container(
    height: double.infinity,
  
    child: DataTable(
      sortColumnIndex: 0,
      sortAscending: sortAsscending,
      columns: const <DataColumn>[
        DataColumn(label: Row(
          
          
          children: [
            Icon(
                Icons.location_on_rounded,
                size: 15,
              ),
              SizedBox(width: 15,),
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
            DataCell( Text('${troquel.ubicacion}')),    
            DataCell(Text('${troquel.gico}'), showEditIcon: true, onTap: () {}),
            DataCell(Text(troquel.cliente)),
            DataCell(Text('${troquel.referencia}')),
            DataCell(Text(troquel.maquina)),
          ],
        );
      }).toList(),
    ),
  );
}

class MyhomeWidget extends StatefulWidget {
  const MyhomeWidget({super.key});

  @override
  State<MyhomeWidget> createState() => _MyhomeWidgetState();
}



class _MyhomeWidgetState extends State<MyhomeWidget> {
 
  @override
  Widget build(BuildContext context) {
   final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TROQUELES SMURFIT WESTROCK'),
      ),
      body: Row(
        children: [
          Container(
           
            height: size.height,
            width: size.width*0.2,
            child: Column(children: [
              ListTile(
                leading: Icon(Icons.book_rounded) ,
                trailing: Icon(Icons.arrow_circle_right_outlined),

                  title: Text('Bibliaco Troqueles'),
                  onTap: (){}

              ),
              ListTile(
                leading: Icon(Icons.book_rounded) ,
                trailing: Icon(Icons.arrow_circle_right_outlined),

                  title: Text('Bibliaco Troqueles'),
                  onTap: (){}

              ),
              ListTile(
                leading: Icon(Icons.book_rounded) ,
                trailing: Icon(Icons.arrow_circle_right_outlined),

                  title: Text('Bibliaco Troqueles'),
                  onTap: (){}

              ),
              ListTile(
                leading: Icon(Icons.book_rounded) ,
                trailing: Icon(Icons.arrow_circle_right_outlined),

                  title: Text('Bibliaco Troqueles'),
                  onTap: (){}

              ),
              
              
              ],

            ),
            


          ),
           SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: size.width*0.8

                        
                      , // Ancho completo de la pantalla
                    child: _buildTable(),
                  )),
        ],
      ),
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