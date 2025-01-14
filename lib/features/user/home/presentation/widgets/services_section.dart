import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/constants/app_images.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/features/user/home/data/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class ServicesSection extends ConsumerWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(servicesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI Prediction Model',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: Dimensions.imgHeightDefault,
          width: double.infinity,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Service Icon
                Lottie.asset(AppLottie.aiAnimation,height: Dimensions.compareCardWidget),
                const SizedBox(height: 8),
                // Service Title
                Text(
                  'Prediction Model',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                // Service Description
                Text(
                  'Get Your Results',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),

              ],
            ),
          ),
        ),
      ],
    );
  }
}
