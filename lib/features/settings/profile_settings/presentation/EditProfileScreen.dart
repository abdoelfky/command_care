import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/widgets/PrimaryButton.dart';
import 'package:command_care/core/widgets/background_screen.dart';
import 'package:command_care/core/widgets/primary_app_bar.dart';
import 'package:command_care/features/settings/profile_settings/controllers/user_settings_provider.dart';
import 'package:command_care/features/settings/profile_settings/presentation/widgets/gender_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/address_section.dart';
import 'widgets/static_field.dart';


class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSettings = ref.watch(userSettingsProvider);

    return Scaffold(
      appBar: PrimaryAppBar(
        title:('User Settings'),
      ),
      body: BackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              StaticField(
                label: 'Username',
                value: userSettings.username,
                onChanged: (newValue) {
                  ref.read(userSettingsProvider.notifier).state =
                      userSettings.copyWith(username: newValue);
                },
              ),
              const SizedBox(height: 16),
              StaticField(
                label: 'Email',
                value: userSettings.email,
                onChanged: (newValue) {
                  ref.read(userSettingsProvider.notifier).state =
                      userSettings.copyWith(email: newValue);
                },
              ),
              const SizedBox(height: 16),
              GenderField(
                selectedGender: userSettings.gender,
                onChanged: (newGender) {
                  ref.read(userSettingsProvider.notifier).state =
                      userSettings.copyWith(gender: newGender);
                },
              ),
              const SizedBox(height: 16),
              AddressSection(
                userSettings: userSettings,
                onCountryChanged: (newValue) {
                  ref.read(userSettingsProvider.notifier).state =
                      userSettings.copyWith(country: newValue);
                },
                onCityChanged: (newValue) {
                  ref.read(userSettingsProvider.notifier).state =
                      userSettings.copyWith(city: newValue);
                },
                onPostalCodeChanged: (newValue) {
                  ref.read(userSettingsProvider.notifier).state =
                      userSettings.copyWith(postalCode: newValue);
                },
              ),
              const SizedBox(height: 24),
              PrimaryButton(

                onPressed: () {
                  // Save action can be implemented here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings saved successfully')),
                  );
                },
                text:  ('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
