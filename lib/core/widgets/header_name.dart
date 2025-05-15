import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/shared_preferences/shared_preferences.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/features/user/appointments/data/appointment_model.dart';
import 'package:flutter/material.dart';

class HeaderName extends StatelessWidget {
  const HeaderName({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Dimensions.paddingSizeDefault,
          right: Dimensions.paddingSizeDefault,
          top: Dimensions.paddingSizeForteen),
      child: Row(
        children: [
          Icon(
            Icons.waving_hand,
            color: Colors.orangeAccent,
          ),
          SizedBox(
            width: 5,
          ),
           Text(
            'Good Afternoon, ${AppSettingsPreferences().name}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.fontSizeExtraLarge),
          ),
        ],
      ),
    );
  }
}
