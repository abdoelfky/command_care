import 'package:flutter/material.dart';
import 'package:command_care/core/constants/app_colors.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onVisibilityToggle;
  final String text;

  PasswordField({
    required this.controller,
    required this.obscureText,
    required this.onVisibilityToggle
  ,this.text = 'Password'
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: text,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          // Default border color
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          // Border color when focused
          borderRadius: BorderRadius.circular(15),
        ),
        labelStyle:
        TextStyle(color: AppColors.primaryTextColor),
        prefixIcon: Icon(
          Icons.vpn_key_outlined,
          color: AppColors.nexusGreen,
        ),        filled: true,
        fillColor: Colors.white.withOpacity(0.5),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: onVisibilityToggle,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) =>
          value!.isEmpty ? 'Please enter your password' : null,
    );
  }
}
