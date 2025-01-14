import 'package:command_care/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class StaticField extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  const StaticField({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold,fontSize: Dimensions.fontSizeDefault)),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            filled: true, // Enables background fill
            fillColor: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
