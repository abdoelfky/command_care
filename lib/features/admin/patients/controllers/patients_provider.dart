import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:command_care/features/admin/patients/data/patient_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final patientProvider = StreamProvider<List<Patient>>((ref) async* {
  final query = FirebaseFirestore.instance
      .collection('users')
      .where('userType', isEqualTo: 'user');

  yield* query.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Patient.fromMap(doc.data())).toList();
  });
});
