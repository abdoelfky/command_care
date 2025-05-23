import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/core/widgets/background_screen.dart';
import 'package:command_care/core/widgets/header_name.dart';
import 'package:command_care/features/admin/doctors/add_doctor/controllers/add_doctor_controller.dart';
import 'package:command_care/features/admin/doctors/add_doctor/presentation/add_doctor_screen.dart';
import 'package:command_care/features/admin/doctors/controllers/doctors_provider.dart';
import 'package:command_care/features/admin/doctors/controllers/patient_search_provider.dart';
import 'package:command_care/features/admin/doctors/presentation/widgets/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorsScreen extends ConsumerWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorAsyncValue = ref.watch(filteredDoctorsProvider);
    final searchQuery = ref.watch(doctorSearchQueryProvider.notifier);
    final handleDoctorsController = ref.read(addDoctorControllerProvider.notifier);

    return Scaffold(
      body: BackgroundScreen(
        child: Column(
          children: [
            HeaderName(),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeDefault,
                horizontal: Dimensions.paddingSizeDefault,
              ),
              child: TextField(
                onChanged: (value) => searchQuery.state = value,
                decoration: InputDecoration(
                  hintText: 'Search doctor',
                  hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  prefixIcon: Icon(Icons.search, color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Note: Swipe left to edit or delete details',
                style: TextStyle(color: Colors.redAccent, fontSize: 12),
              ),
            ),
            doctorAsyncValue.when(
              data: (doctors) => Expanded(
                child: doctors.isEmpty
                    ? const Center(child: Text('No doctors found.'))
                    : ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return DoctorCard(
                      key: ValueKey(doctor.id),
                      doctorModel: doctor,
                      onDelete: () async {
                        await handleDoctorsController.removeDoctor(uid: doctor.id);
                        ref.refresh(doctorsProvider);
                      },
                      onEdit: () {},
                    );
                  },
                ),
              ),
              loading: () => const Expanded(child: Center(child: CircularProgressIndicator())),
              error: (e, _) => Expanded(child: Center(child: Text('Error: $e'))),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDoctorScreen()),
          ).then((_) => ref.refresh(doctorsProvider));
        },
        backgroundColor: AppColors.floatingActionButtonColor,
        child: Icon(Icons.add, color: AppColors.whiteColor),
      ),
    );
  }
}
