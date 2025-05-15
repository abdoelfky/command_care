import 'package:command_care/features/admin/patients/data/patient_model.dart';
import 'package:command_care/features/admin/patients/controllers/patients_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final patientSearchQueryProvider = StateProvider<String>((ref) => '');

final filteredPatientProvider = Provider<AsyncValue<List<Patient>>>((ref) {
  final searchQuery = ref.watch(patientSearchQueryProvider).toLowerCase();
  final patientsAsync = ref.watch(patientProvider);

  return patientsAsync.whenData((patients) {
    if (searchQuery.isEmpty) return patients;
    return patients
        .where((patient) => patient.name.toLowerCase().contains(searchQuery))
        .toList();
  });
});
