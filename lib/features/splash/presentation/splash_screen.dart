import 'package:command_care/features/doctor/home/presentation/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/constants/app_constants.dart';
import 'package:command_care/core/constants/app_images.dart';
import 'package:command_care/core/shared_preferences/shared_preferences.dart';
import 'package:command_care/core/widgets/background_screen.dart';
import 'package:command_care/features/admin/home/presentation/dashboard.dart';
import 'package:command_care/features/auth/presentation/auth_screen.dart';
import 'package:command_care/features/user/home/presentation/dashboard.dart';

import 'bouncy_widget.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use a stateful approach for the delayed navigation
    Future.delayed(Duration(seconds: 2), () {
      // Check if the widget is still mounted
      if (context.mounted) {

        if(AppSettingsPreferences().id != '') {
          if (AppSettingsPreferences().userType.toLowerCase() == UserType.admin.value.toLowerCase()) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => AdminDashBoardScreen()));
          }else if (AppSettingsPreferences().userType.toLowerCase() == UserType.doctor.value.toLowerCase()) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => DoctorDashBoardScreen()));
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => UserDashBoardScreen()));
          }
        }else
        {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        }
      }
    });

    return Scaffold(
      body: BackgroundScreen(
        // imgSrc: AppImages.splashBackground,
        child: Stack(
          children: [
            Positioned.fill(
              child:Stack(
                children: [
                  Image.asset(
                    AppImages.splashBackground, // Replace with the image path
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5), // Black layer with 50% opacity
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ],
              )

            ),
            // Centered Image
            Positioned(
              top: MediaQuery.of(context).size.height*.4,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 120,
                width: 120,
                child: BouncyWidget(
                    duration: const Duration(milliseconds: 2000),
                    lift: 50,
                    ratio: 0.5,
                    pause: 0.25,
                    child: SizedBox(
                        child: Image.asset(AppImages.logo))),
              ),
        
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
        
                Spacer(), // Pushes the "Approved" text to the bottom
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min, // Take up minimum space
                      children: [
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.whiteTextColor, // Text color for version
                          ),
                        ),
                        const SizedBox(width: 8), // Space between text
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.nexusGreen, // Use your defined green color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
