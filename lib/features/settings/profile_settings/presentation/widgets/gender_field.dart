import 'package:command_care/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class GenderField extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String> onChanged;

  const GenderField({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Gender', style: TextStyle(fontWeight: FontWeight.bold)),
        // const SizedBox(height: 8),
        Row(
          children: ['Male', 'Female']
              .map(
                (gender) => Row(
              children: [
                Radio<String>(
                  value: gender,
                  fillColor: WidgetStateProperty.all(AppColors.primaryColor),
                  groupValue: selectedGender,
                  onChanged: (value) {
                    if (value != null) {
                      onChanged(value); // Call the non-nullable callback
                    }
                  },
                ),
                Text(gender),
              ],
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}
