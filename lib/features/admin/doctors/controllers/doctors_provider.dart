import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/doctor_model.dart';


final doctorsProvider = FutureProvider<List<DoctorModel>>((ref) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('Doctors')
      .get();

  return snapshot.docs.map((doc) {
    return DoctorModel.fromMap(doc.data());
  }).toList();
});
