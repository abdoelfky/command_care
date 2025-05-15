import 'package:command_care/core/widgets/background_screen.dart';
import 'package:command_care/core/widgets/header_name.dart';
import 'package:command_care/features/doctor/home/controllers/providers.dart.dart';
import 'package:command_care/features/doctor/home/presentation/widgets/statistics_section.dart';
import 'package:command_care/features/doctor/home/presentation/widgets/weekly_appointments_chart.dart';
import 'package:command_care/features/user/home/presentation/widgets/services_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:command_care/core/utils/dimensions.dart';

import 'widgets/appointments_list.dart';

class DoctorHomeScreen extends ConsumerWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statsProvider);
    final weeklyAppointments = ref.watch(weeklyAppointmentsProvider);
    final appointments = ref.watch(appointmentsProvider);

    return Scaffold(
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderName(),
                ServicesSection(),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                StatisticsSection(),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                WeeklyAppointmentsChart(data: weeklyAppointments),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                AppointmentsList(appointments: appointments),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
