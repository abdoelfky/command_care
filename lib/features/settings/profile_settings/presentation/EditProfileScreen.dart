import 'package:command_care/core/shared_preferences/shared_preferences.dart';
import 'package:command_care/core/widgets/PrimaryButton.dart';
import 'package:command_care/core/widgets/PrimaryTextFormField.dart';
import 'package:command_care/core/widgets/background_screen.dart';
import 'package:command_care/core/widgets/primary_app_bar.dart';
import 'package:command_care/features/settings/profile_settings/controllers/user_settings_provider.dart';
import 'package:command_care/features/settings/profile_settings/presentation/widgets/gender_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: AppSettingsPreferences().name);
    _emailController = TextEditingController(text: AppSettingsPreferences().email);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PrimaryAppBar(
        title: 'User Settings',
      ),
      body: BackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              PrimaryTextFormField(
                label: 'Username',
                controller: _usernameController,
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 16),
              PrimaryTextFormField(
                label: 'Email',
                controller: _emailController,
                prefixIcon: Icons.email,

              ),
              const SizedBox(height: 16),
              GenderField(
                selectedGender: AppSettingsPreferences().gender,
                onChanged: (newGender) {
                  setState(() {
                    AppSettingsPreferences().setGender(gender: newGender);

                  });
                },
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Settings saved successfully'),
                    ),
                  );
                },
                text: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
