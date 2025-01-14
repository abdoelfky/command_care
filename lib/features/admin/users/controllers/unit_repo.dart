import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:command_care/features/auth/data/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UnitRepository {
  final FirebaseFirestore _firestore;

  UnitRepository(this._firestore);

  Future<List<UserData>> fetchUnits() async {
    final querySnapshot = await _firestore.collection('units').get();
    return querySnapshot.docs
        .map((doc) => UserData.fromMap(doc.data()))
        .toList();
  }

  // Method to delete a unit from Firestore
  Future<void> deleteUnit(String unitId) async {
    try {
      await _firestore.collection('units').doc(unitId).delete();
    } catch (e) {
      throw Exception('Failed to delete unit: $e');
    }
  }
}
