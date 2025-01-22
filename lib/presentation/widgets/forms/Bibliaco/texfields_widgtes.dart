import 'package:flutter/material.dart';

import '../../../../utils/input_decorations.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String value;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.label,
    required this.value, required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          enabled: enabled,
          controller: TextEditingController(text: value),
          decoration: InputDecorations.authInputDescoration(
            hintText: label,
            labelText: label,
          ),
        
        ),
        const SizedBox(height: 10,)
      ],
    );
      
      
  }
}
