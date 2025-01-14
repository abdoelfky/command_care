import 'package:command_care/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

import 'appointment_card.dart';

class AppointmentsList extends StatelessWidget {
  final List<Map<String, String>> appointments;

  const AppointmentsList({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Appointments', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        ...appointments.map((appointment) => AppointmentCard(data: appointment)).toList(),
      ],
    );
  }
}
