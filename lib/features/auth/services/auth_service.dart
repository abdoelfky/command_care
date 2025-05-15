import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:command_care/features/auth/data/User.dart';
import 'package:command_care/features/doctor/home/presentation/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:command_care/core/constants/app_constants.dart';
import 'package:command_care/core/shared_preferences/shared_preferences.dart';
import 'package:command_care/features/admin/home/presentation/dashboard.dart';
import 'package:command_care/features/auth/controllers/auth_provider.dart';
import 'package:command_care/features/user/home/presentation/dashboard.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class AuthService {
  final WidgetRef ref;

  AuthService(this.ref);

  Future<void> handleLogin(BuildContext context, String email, String password) async {
    try {
      // Sign in with Firebase Auth
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      // Get user role from Firestore
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        throw Exception('User data not found in database');
      }

      final userData = userDoc.data()!;
      final userType = userData['userType'];

      // Save locally if you need (optional)
      await AppSettingsPreferences().saveUser(
        user: UserData(
          id: uid,
          gender: userData['gender']??'',
          userType: userType,
          phoneNumber: userData['phoneNumber'],
          name: userData['name'],
          email: email,
          password: password,
        ),
      );

      await Future.delayed(Duration(milliseconds: 500));

      // Navigate based on user type
      Widget destinationScreen;
      if (userType == 'admin') {
        destinationScreen = AdminDashBoardScreen();
      } else if (userType == 'user') {
        destinationScreen = UserDashBoardScreen();
      } else if (userType == 'doctor') {
        destinationScreen = DoctorDashBoardScreen();
      } else {
        throw Exception('Unknown user type');
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => destinationScreen),
            (Route<dynamic> route) => false,
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    }
  }



  Future<void> handleForgetPassword(BuildContext context, String email) async {
    await ref
        .read(firebaseAuthServiceProvider)
        .resetPassword(context: context, email: email);
  }
}
