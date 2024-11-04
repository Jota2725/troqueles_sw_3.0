import 'package:flutter/material.dart';

class MenuTroqueles extends StatelessWidget {
  const MenuTroqueles({
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
          SizedBox(
            height: 200,
            width: double.maxFinite,
            child: const Image(
                image: AssetImage('assets/Smurfit_Westrock_(logo).png')),
          ),
          ListTile(
              hoverColor: Colors.blue.shade100,
              leading: const Icon(
                Icons.home,
                color: Color.fromRGBO(23, 13, 171, 1),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Color.fromRGBO(23, 13, 171, 1),
              ),
              title: const Text('Inicio'),
              onTap: () {}),
          const SizedBox(
            height: 10,
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