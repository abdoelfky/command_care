import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/core/widgets/background_screen.dart';
import 'package:command_care/core/widgets/header_name.dart';
import 'package:command_care/features/admin/patients/add_patient/presentation/add_user_screen.dart';
import 'package:command_care/features/doctor/patients/controllers/patient_provider.dart';
import 'package:command_care/features/doctor/patients/presentation/widgets/patient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorPatientsScreen extends ConsumerWidget {
  const DoctorPatientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patients = ref.watch(doctorPatientProvider);

    return Scaffold(
      body: BackgroundScreen(
        child: Column(
          children: [
            HeaderName(),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeDefault,
                  horizontal: Dimensions.paddingSizeDefault),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Patient',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600, // Hint text color
                    fontSize: 16, // Hint text size
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blue, // Icon color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      // Border color when not focused
                      width: 1.5, // Border width
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.blue, // Border color when focused
                      width: 2, // Border width when focused
                    ),
                  ),
                  filled: true,
                  fillColor: Colors
                      .grey.shade100, // Background color of the text field
                ),
                style: TextStyle(
                  color: Colors.black, // Text color
                  fontSize: 16, // Text size
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  child: const Text(
                    'Note: Swipe left to edit or delete details',
                    style: TextStyle(color: Colors.redAccent, fontSize: 12),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  return PatientCard(
                      patient: patients[index], onDelete: () {}, onEdit: () {});
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPatientScreen()),
          );
        },

        backgroundColor: AppColors.floatingActionButtonColor,
        child: Icon(
          Icons.add,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
