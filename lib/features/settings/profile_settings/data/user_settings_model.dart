class UserSettings {
  final String username;
  final String email;
  final String gender;
  final String country;
  final String city;
  final String postalCode;

  UserSettings({
    required this.username,
    required this.email,
    required this.gender,
    required this.country,
    required this.city,
    required this.postalCode,
  });

  // Define the copyWith method
  UserSettings copyWith({
    String? username,
    String? email,
    String? gender,
    String? country,
    String? city,
    String? postalCode,
  }) {
    return UserSettings(
      username: username ?? this.username,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
    );
  }
}
