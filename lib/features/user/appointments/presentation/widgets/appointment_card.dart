import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/features/user/appointments/data/appointment_model.dart';
import 'package:flutter/material.dart';

import '../../../../admin/admin_appointments/data/appointment_model.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Card(
      color:AppColors.whiteColor ,

      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(appointment.image),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                appointment.doctorName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: Dimensions.paddingSizeExtraSmall,),
            Chip(
              label: Text(
                appointment.status,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12, // Smaller font for compact design
                ),
              ),
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 8), // Horizontal padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Increased radius
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduces height
            )

          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appointment.specialization,maxLines: 1,),
            Text('📅 ${appointment.date}',maxLines: 1,),
            Text('⏰ ${appointment.time}',maxLines: 1,),
          ],
        ),
      ),
    );
  }
}
