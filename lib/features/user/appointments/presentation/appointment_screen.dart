import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/core/widgets/background_screen.dart';
import 'package:command_care/core/widgets/header_name.dart';
import 'package:command_care/features/user/appointments/presentation/widgets/filter_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/appointment_provider.dart';
import 'widgets/appointment_card.dart';

class AppointmentScreen extends ConsumerStatefulWidget {
  const AppointmentScreen({super.key});

  @override
  ConsumerState<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends ConsumerState<AppointmentScreen> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final appointments = ref.watch(appointmentProvider);

    final filteredAppointments = appointments.where((appointment) {
      if (selectedFilter == 'All') return true;
      return appointment.status == selectedFilter;
    }).toList();

    return Scaffold(
      body: BackgroundScreen(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderName(),
            SizedBox(
              height: Dimensions.paddingSizeSmall,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'My Appointments',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: Dimensions.paddingSizeSmall,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
              child: FilterButtons(
                onFilterSelected: (filter) {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredAppointments.length,
                itemBuilder: (context, index) {
                  return AppointmentCard(
                    appointment: filteredAppointments[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.floatingActionButtonColor,
        child: const Icon(
          Icons.add,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
