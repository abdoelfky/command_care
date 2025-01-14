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


// Doctor Model
class Doctor {
  final String name;
  final String initial;

  Doctor(this.name, this.initial);
}


final doctorsProvider = Provider<List<Doctor>>((ref) => [
  Doctor('Dr. Himesh Kailasia', 'D'),
  Doctor('Dr. Eugene Precious', 'E'),
]);
