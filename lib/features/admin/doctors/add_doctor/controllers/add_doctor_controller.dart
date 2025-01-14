import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final addDoctorControllerProvider =
StateNotifierProvider<SignUpController, bool>((ref) => SignUpController());

class SignUpController extends StateNotifier<bool> {
  SignUpController() : super(false); // `false` indicates not loading

  Future<void> addDoctor({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    state = true; // Set loading to true
    try {
      // Create Firebase user
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final String uid = userCredential.user?.uid ?? '';

      // Save user details to Firestore
      await FirebaseFirestore.instance.collection('Doctors')
          .doc(userCredential.user?.uid).set({
        'email': email,
        'phone': phone,
        'password': password,
        'name': name,
        'id': uid,
        'userType':'user',
        'is_rented':false,
        'created_at': Timestamp.now(),
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Firebase Authentication Error');
    } catch (e) {
      throw Exception('Failed to add doctor');
    } finally {
      state = false; // Set loading to false
    }
  }
}
