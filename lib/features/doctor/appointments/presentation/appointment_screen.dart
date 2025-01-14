import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/core/widgets/background_screen.dart';
import 'package:command_care/core/widgets/header_name.dart';
import 'package:command_care/features/doctor/appointments/data/appointment_provider.dart';
import 'package:command_care/features/doctor/appointments/presentation/widgets/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorAppointmentScreen extends ConsumerStatefulWidget {
  const DoctorAppointmentScreen({super.key});

  @override
  ConsumerState<DoctorAppointmentScreen> createState() =>
      _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState
    extends ConsumerState<DoctorAppointmentScreen> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final appointments = ref.watch(doctorAppointmentProvider);

    final filteredAppointments = appointments.where((appointment) {
      if (selectedFilter == 'All') return true;
      return appointment.status == selectedFilter;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light blue background
      body: BackgroundScreen(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            HeaderName(),
            const SizedBox(height: 16),

            // Calendar Widget
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.arrow_back_ios,
                            size: 16, color: Colors.black54),
                        Text(
                          'Today\nJanuary 2025',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.black54),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(7, (index) {
                        final days = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun'
                        ];
                        final currentDay = DateTime.now().day;

                        return Column(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  index == 1 ? Colors.blue : Colors.transparent,
                              child: Text(
                                (currentDay + index - 1).toString(),
                                style: TextStyle(
                                  color:
                                      index == 1 ? Colors.white : Colors.black,
                                  fontWeight: index == 1
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              days[index],
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Tuesday January 07, 2025',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Appointment Cards
            Expanded(
              child: ListView.builder(
                itemCount: filteredAppointments.length,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                itemBuilder: (context, index) {
                  final appointment = filteredAppointments[index];
                  return AppointmentCard(appointment: appointment);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add appointment logic here
        },
        backgroundColor: AppColors.floatingActionButtonColor,

        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

