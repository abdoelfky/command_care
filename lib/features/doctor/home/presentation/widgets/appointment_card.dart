import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final Map<String, String> data;

  const AppointmentCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 5, spreadRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data['id']!, style: TextStyle(color: AppColors.greyColor)),
              Text(data['status']!, style: TextStyle(color: AppColors.greenColor)),
            ],
          ),
          Text(data['name']!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(data['type']!, style: TextStyle(color: AppColors.greyColor)),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: AppColors.greyColor),
              const SizedBox(width: 5),
              Text('${data['date']} • ${data['time']}'),
            ],
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('View'),
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.lightRed),
                  child: Text('Check In'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
