import 'package:command_care/core/widgets/header_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/core/widgets/background_screen.dart';
import 'widgets/services_section.dart';
import 'widgets/top_doctors_section.dart';
import 'widgets/health_tips_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderName(),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                TopDoctorsSection(),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                HealthTipsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
