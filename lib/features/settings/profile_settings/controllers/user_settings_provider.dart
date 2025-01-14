import 'package:command_care/features/settings/profile_settings/data/user_settings_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userSettingsProvider = StateProvider<UserSettings>((ref) {
  return UserSettings(
    username: 'JohnDoe',
    email: 'johndoe@example.com',
    gender: 'Male',
    country: 'USA',
    city: 'New York',
    postalCode: '10001',
  );
});
