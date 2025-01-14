import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/doctor_model.dart';

final doctorsProvider = Provider<List<DoctorModel>>((ref) {
  return [
    DoctorModel(
        name: 'Ted Hdl',
        id: '1',
        phone: '6837648464',
        gender: 'female',
        encounterStatus: 'No Encounter Found',
        status: 'Active'),
    DoctorModel(
        name: 'T K',
        id: '2',
        phone: '0987654321',
        gender: 'other',
        encounterStatus: 'Total 2 Encounter',
        status: 'Active'),
    DoctorModel(
        name: 'Shashi Sahu',
        phone: '8349511700',
        id: '3',
        gender: 'other',
        encounterStatus: 'No Encounter Found',
        status: 'Active'),
    DoctorModel(
        name: 'Umee Sial',
        phone: '0345425848',
        id: '4',
        gender: 'male',
        encounterStatus: 'No Encounter Found',
        status: 'Active'),
  ];
});
