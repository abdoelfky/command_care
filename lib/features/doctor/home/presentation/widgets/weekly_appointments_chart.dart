import 'package:command_care/core/utils/dimensions.dart';
import 'package:flutter/material.dart';

class WeeklyAppointmentsChart extends StatelessWidget {
  final List<int> data;

  const WeeklyAppointmentsChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Weekly Appointments',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                // Add your action for "More" here
              },
              child: const Text(
                'More',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
         SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Y-axis labels
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  int label = 20 - (index * 5); // Reverse the numbers
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      label.toString(),
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                  );
                }),
              ),

              SizedBox(width: Dimensions.paddingSizeDefault),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: data.asMap().entries.map((entry) {
                    int value = entry.value;
                    double heightFactor = value / 20.0;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 100 * heightFactor, // Dynamic height
                          width: 20, // Bar width
                          decoration: BoxDecoration(
                            color:
                                Colors.red.withOpacity(0.5 + heightFactor / 2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        // const SizedBox(height: 88),
                        Text(
                          [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun'
                          ][entry.key],
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
