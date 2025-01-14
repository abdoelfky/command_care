import 'package:command_care/features/doctor/home/presentation/widgets/statistics_card.dart';
import 'package:flutter/material.dart';

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StatisticsCard(
          title: 'Today Appoint.',
          value: 1,
          icon: Icons.calendar_month_outlined,
          iconColor: Colors.red,
        ),
        StatisticsCard(
          title: 'Total Appoint.',
          value: 123,
          icon: Icons.calendar_month_outlined,
          iconColor: Colors.blue,
        ),
        StatisticsCard(
          title: 'Total Patient',
          value: 36,
          icon: Icons.person,
          iconColor: Colors.red,
        ),
      ],
    );
  }
}
