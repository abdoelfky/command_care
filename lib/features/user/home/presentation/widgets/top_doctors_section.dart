import 'package:command_care/core/constants/app_colors.dart';
import 'package:command_care/core/utils/dimensions.dart';
import 'package:command_care/features/admin/doctors/controllers/doctors_provider.dart';
import 'package:command_care/features/user/home/data/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopDoctorsSection extends ConsumerWidget {
  const TopDoctorsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var doctorAsyncValue = ref.watch(doctorsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Top Doctors',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              'View All',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.red.withOpacity(.7),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),

        doctorAsyncValue.when(
          data: (doctors) => ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  child: ListTile(
                      leading: CircleAvatar(
                        child: Text(doctors[index].name[0]),
                      ),
                      title: Text("Dr ${doctors[index].name}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold)),
                      trailing: GestureDetector(
                        onTap: () {},
                        child: Chip(
                          label: Text(
                            'View',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12, // Smaller font for compact design
                            ),
                          ),
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          // Horizontal padding
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(20), // Increased radius
                          ),
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap, // Reduces height
                        ),
                      )),
                ),
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ],
    );
  }
}
