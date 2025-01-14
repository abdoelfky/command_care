import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/features/settings/profile_settings/data/user_settings_model.dart';
import 'package:flutter/material.dart';

class AddressSection extends StatelessWidget {
  final UserSettings userSettings;
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onCityChanged;
  final ValueChanged<String> onPostalCodeChanged;

  const AddressSection({
    Key? key,
    required this.userSettings,
    required this.onCountryChanged,
    required this.onCityChanged,
    required this.onPostalCodeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Address Details',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(
          controller: TextEditingController(text: userSettings.country),
          onChanged: onCountryChanged,
          decoration: const InputDecoration(
              labelText: 'Country',
              filled: true,
              fillColor: AppColors.whiteColor,
              border: OutlineInputBorder()),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: userSettings.city),
          onChanged: onCityChanged,
          decoration: const InputDecoration(
              labelText: 'City',
              filled: true,
              fillColor: AppColors.whiteColor,
              border: OutlineInputBorder()),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: userSettings.postalCode),
          onChanged: onPostalCodeChanged,
          decoration: const InputDecoration(
              fillColor: AppColors.whiteColor,
              labelText: 'Postal Code',
              filled: true,
              border: OutlineInputBorder()),
        ),
      ],
    );
  }
}
