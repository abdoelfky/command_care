import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

// Service Model
class Service {
  final String title;
  final String description;
  final IconData icon; // Use IconData instead of String for icon

  Service(this.title, this.description, this.icon);
}

// Static Data Providers
final servicesProvider = Provider<List<Service>>((ref) => [
  Service('Capping', '1 Doctor Available', Icons.medical_services),
  Service('Dentist', '1 Doctor Available', Icons.health_and_safety),
]);


