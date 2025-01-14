import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/features/user/home/controllers/bottom_nav_provider.dart';

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavState = ref.watch(bottomNavProvider);
    return BottomNavigationBar(
      currentIndex: bottomNavState.selectedIndex,
      onTap: (index) {
        ref.read(bottomNavProvider.notifier).selectIndex(index);
      },
      // backgroundColor: Colors.red,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.greyColor,
      selectedLabelStyle: TextStyle(
          fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w700),
      items: const [
        BottomNavigationBarItem(
            backgroundColor: AppColors.bottomNavBarColor,
            icon: Icon(
              Icons.home,
              size: Dimensions.iconSizeLarge,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            backgroundColor: AppColors.bottomNavBarColor,
            icon: Icon(
              Icons.calendar_month,
              size: Dimensions.iconSizeLarge,
            ),
            label: 'Appointment'),
        BottomNavigationBarItem(
            backgroundColor: AppColors.bottomNavBarColor,
            icon: Icon(
              Icons.settings,
              size: Dimensions.iconSizeLarge,
            ),
            label: 'Settings'),
      ],
    );
  }
}