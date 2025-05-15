import 'package:command_care/features/admin/doctors/controllers/doctors_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final doctorSearchQueryProvider = StateProvider<String>((ref) => '');
final filteredDoctorsProvider = Provider((ref) {
  final query = ref.watch(doctorSearchQueryProvider).toLowerCase();
  final doctorsAsync = ref.watch(doctorsProvider);

  return doctorsAsync.whenData((doctors) {
    if (query.isEmpty) return doctors;
    return doctors.where((doc) {
      return doc.name.toLowerCase().contains(query);
    }).toList();
  });
});
