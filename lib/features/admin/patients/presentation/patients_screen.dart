import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/core/widgets/background_screen.dart';
import 'package:command_care/core/widgets/header_name.dart';
import 'package:command_care/features/admin/patients/add_patient/presentation/add_user_screen.dart';
import 'package:command_care/features/admin/patients/controllers/patient_search_provider.dart';
import 'package:command_care/features/admin/patients/controllers/patients_provider.dart';
import 'package:command_care/features/admin/patients/presentation/widgets/patient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientsScreen extends ConsumerWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientAsyncValue = ref.watch(filteredPatientProvider);
    final searchQuery = ref.watch(patientSearchQueryProvider.notifier);

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
                  hintText: 'Search Patient',
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
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Note: Swipe left to edit or delete details',
                style: TextStyle(color: Colors.redAccent, fontSize: 12),
              ),
            ),
            patientAsyncValue.when(
              data: (patients) => Expanded(
                child: patients.isEmpty
                    ? const Center(child: Text('No patients found.'))
                    : ListView.builder(
                  itemCount: patients.length,
                  itemBuilder: (context, index) {
                    final patient = patients[index];
                    return PatientCard(
                      patient: patient,
                      onDelete: () {},
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
            MaterialPageRoute(builder: (context) => const AddPatientScreen()),
          ).then((_) => ref.refresh(patientProvider));
        },
        backgroundColor: AppColors.floatingActionButtonColor,
        child: Icon(Icons.add, color: AppColors.whiteColor),
      ),
    );
  }
}
