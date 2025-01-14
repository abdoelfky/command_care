import 'package:command_care/features/auth/data/User.dart';
import 'package:command_care/features/doctor/home/presentation/dashboard.dart';
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

  // Future<void> handleLogin(
  //     BuildContext context, String email, String password) async {
  //   final authService = ref.read(firebaseAuthServiceProvider);
  //   final success = await authService.signIn(
  //       context: context, email: email, password: password);
  //   if (success) {
  //     print(AppSettingsPreferences().userType.toLowerCase().toString());
  //     if (AppSettingsPreferences().userType.toLowerCase() ==
  //         UserType.admin.value.toLowerCase()) {
  //       Future.delayed(Duration(milliseconds: 500), () {
  //         Navigator.pushReplacement(context,
  //             MaterialPageRoute(builder: (_) => AdminDashBoardScreen()));
  //       });
  //     } else {
  //       Future.delayed(Duration(milliseconds: 500), () {
  //         Navigator.pushReplacement(context,
  //             MaterialPageRoute(builder: (_) => UserDashBoardScreen()));
  //       });
  //     }
  //   }
  // }

  Future<void> handleLogin(
      BuildContext context, String email, String password) async {
    try {
      if (email == 'admin@gmail.com' && password == '12344321') {
        await AppSettingsPreferences().saveUser(
          user: UserData(
            id: '1',
            userType: 'admin',
            phoneNumber: '010626095550',
            name: 'Admin User',
            email: email,
            password: password,
          ),
        );

        await Future.delayed(Duration(milliseconds: 500));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => AdminDashBoardScreen()),
              (Route<dynamic> route) => false, // Removes all previous routes
        );
      } else if (email == 'user@gmail.com' && password == '12344321') {
        await AppSettingsPreferences().saveUser(
          user: UserData(
            id: '2',
            userType: 'user',
            phoneNumber: '010626095550',
            name: 'Regular User',
            email: email,
            password: password,
          ),
        );

        await Future.delayed(Duration(milliseconds: 500));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => UserDashBoardScreen()),
              (Route<dynamic> route) => false, // Removes all previous routes
        );
      }
      else if (email == 'doctor@gmail.com' && password == '12344321') {
        await AppSettingsPreferences().saveUser(
          user: UserData(
            id: '2',
            userType: 'doctor',
            phoneNumber: '010626095550',
            name: 'Dr Mohamed',
            email: email,
            password: password,
          ),
        );

        await Future.delayed(Duration(milliseconds: 500));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => DoctorDashBoardScreen()),
              (Route<dynamic> route) => false, // Removes all previous routes
        );
      }else {
        throw Exception('Invalid email or password');
      }
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
