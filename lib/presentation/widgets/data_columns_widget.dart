import 'package:flutter/material.dart';

class DataColums extends StatelessWidget {
  final IconData? icon;
  final String text;

  const DataColums({
    super.key,
    this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          if (icon != null) Icon(icon),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}
