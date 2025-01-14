import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/features/auth/controllers/toggle_index_notifier.dart';

// AuthToggleButtons Widget
class AuthToggleButtons extends StatelessWidget {
  final int selectedIndex;
  final WidgetRef ref;

  const AuthToggleButtons({
    Key? key,
    required this.selectedIndex,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [selectedIndex == 0, selectedIndex == 1],
      color: AppColors.whiteTextColor,
      selectedColor: AppColors.whiteTextColor,
      fillColor: AppColors.primaryTextColor,
      borderColor: AppColors.primaryTextColor.withOpacity(.5),
      borderRadius: BorderRadius.circular(15),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text('Login'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text('Forgot Password'),
        ),
      ],
      onPressed: (index) {
        ref.read(toggleIndexProvider.notifier).setIndex(index);
      },
    );
  }
}
