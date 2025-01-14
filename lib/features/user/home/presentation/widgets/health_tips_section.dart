import 'package:command_care/core/constants/app_images.dart';
import 'package:flutter/material.dart';

class HealthTipsSection extends StatelessWidget {
  const HealthTipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Experts Health Tips and Advice',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        const Text(
          'Articles by highly qualified doctors on everyday health..',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            AppImages.bannerImg1,
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
