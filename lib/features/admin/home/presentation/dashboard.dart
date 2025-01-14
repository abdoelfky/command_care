import 'package:command_care/features/admin/admin_appointments/presentation/admin_appointment_screen.dart';
import 'package:command_care/features/admin/doctors/presentation/doctors_screen.dart';
import 'package:command_care/features/admin/patients/presentation/patient_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:command_care/features/profile/profile_screen.dart';
import 'package:command_care/features/user/home/controllers/bottom_nav_provider.dart';

import 'widgets/custom_bottom_nav_bar.dart';

class AdminDashBoardScreen extends ConsumerWidget {
  AdminDashBoardScreen({super.key});
  // Define the screens corresponding to each tab
  List<Widget> screens = [
    AdminAppointmentScreen(),
    PatientsScreen(),
    DoctorsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current index from the bottomNavProvider
    final currentIndex = ref.watch(bottomNavProvider).selectedIndex;
    final pageStorageKey = GlobalKey();



    return Scaffold(
      // backgroundColor: Colors.white,
      body: PageStorage(
        key: pageStorageKey,
        bucket: PageStorageBucket(),
        child: screens[currentIndex], // Display the selected screen
      ),
      bottomNavigationBar: AdminCustomBottomNavBar(), // Bottom navigation bar
    );
  }
}
