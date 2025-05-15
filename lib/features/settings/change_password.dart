import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/core/widgets/PrimaryButton.dart';
import 'package:command_care/core/widgets/background_screen.dart';
import 'package:command_care/features/admin/home/presentation/widgets/custom_app_bar.dart';
import 'package:command_care/features/auth/presentation/widgets/passwordField.dart';

import '../../core/widgets/primary_app_bar.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool _obscureOld = true;
  bool _obscureNew = true;

  var state;
  bool _obscurePassword = true;

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    setState(() => state = 'loading');

    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;

    if (email == null) {
      setState(() => state = 'error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User email not found.')),
      );
      return;
    }

    final credential =
        EmailAuthProvider.credential(email: email, password: oldPassword);

    try {
      // Reauthenticate
      await user!.reauthenticateWithCredential(credential);

      // Then change password
      await user.updatePassword(newPassword);

      setState(() {
        state = 'success';
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmNewPasswordController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Password changed successfully'),
          backgroundColor: AppColors.successColor,
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => state = 'error');

      String errorMessage = switch (e.code) {
        'wrong-password' => 'Incorrect old password.',
        'weak-password' => 'Password should be at least 6 characters.',
        'requires-recent-login' =>
          'Please log in again to update your password.',
        _ => 'Password change failed: ${e.message}',
      };

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      setState(() => state = 'error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PrimaryAppBar(title: 'Settings'),
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Change Password',
                    style: TextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: Dimensions.fontSizeLarge,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: size.height * .07,
                  ),
                  PasswordField(
                    text: 'Old Password',
                    controller: oldPasswordController,
                    obscureText: _obscureOld,
                    onVisibilityToggle: () =>
                        setState(() => _obscureOld = !_obscureOld),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  PasswordField(
                    text: 'New Password',
                    controller: newPasswordController,
                    obscureText: _obscureNew,
                    onVisibilityToggle: () =>
                        setState(() => _obscureNew = !_obscureNew),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  ConditionalBuilder(
                    condition: state != 'loading',
                    builder: (context) => PrimaryButton(
                      text: 'Change Password',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          changePassword(
                              oldPassword: oldPasswordController.text,
                              newPassword: newPasswordController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('please enter password')),
                          );
                        }
                      },
                    ),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
