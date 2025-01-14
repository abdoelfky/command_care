import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:command_care/features/help/data/complaintModel.dart';

final complaintsProvider = StreamProvider.autoDispose<List<Complaint>>((ref) {
  final firestore = FirebaseFirestore.instance;
  final complaintsStream = firestore.collection('complaints').orderBy('createdAt', descending: true).snapshots();

  return complaintsStream.map((snapshot) => snapshot.docs.map((doc) {
    return Complaint.fromFirestore(doc.id, doc.data());
  }).toList());
});
