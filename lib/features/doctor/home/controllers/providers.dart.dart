import 'package:flutter_riverpod/flutter_riverpod.dart';

final statsProvider = Provider((ref) => {
  'todayAppointments': 1,
  'totalAppointments': 123,
  'totalPatients': 36,
});

final weeklyAppointmentsProvider = Provider<List<int>>((ref) => [10, 20, 15, 18, 20, 12, 14]);

final appointmentsProvider = Provider<List<Map<String, String>>>((ref) => [
  {'id': '#795', 'name': 'T K', 'type': 'Telem', 'date': '07-01-2025', 'time': '02:00 PM - 03:00 PM', 'status': 'Booked'},
]);
